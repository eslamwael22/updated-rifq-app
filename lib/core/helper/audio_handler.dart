import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'package:sakina_app/features/quran_audio/data/audio_item_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';

class AudioHandlerHelper extends BaseAudioHandler
    with SeekHandler, QueueHandler {
  final AudioPlayer _player;
  final ReciterDownloadingCubit reciterCubit;

  AudioHandlerHelper(this._player, {required this.reciterCubit}) {
    _initAudioSession();
    _player.playbackEventStream.listen((event) {
      playbackState.add(
        playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            _player.playing ? MediaControl.pause : MediaControl.play,
            MediaControl.stop,
            MediaControl.skipToNext,
          ],
          systemActions: const {
            MediaAction.seek,
            MediaAction.seekForward,
            MediaAction.seekBackward,
          },
          androidCompactActionIndices: const [0, 1, 3],
          processingState: _transformState(_player.processingState),
          playing: _player.playing,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
        ),
      );
      if (_player.processingState == ProcessingState.completed &&
          _playlist.isNotEmpty) {
        Future.microtask(() => skipToNext());
      }
    });
  }

  List<AudioItemModel> _playlist = [];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setPlaylist(List<AudioItemModel> items) {
    if (_playlist.isNotEmpty &&
        _playlist.length == items.length &&
        List.generate(_playlist.length, (i) => _playlist[i].path).join() ==
            List.generate(items.length, (i) => items[i].path).join()) {
      return;
    }

    _playlist = items;
    _currentIndex = 0;

    final mediaItems = _playlist.map((item) {
      return MediaItem(
        id: item.path,
        title: item.title,
        artist: reciterCubit.selectedReciterModel?.name ?? 'غير معروف',
        album: 'القرآن الكريم',
        artUri: Uri.parse('asset://assets/icons/Rifq logo.jpg'),
      );
    }).toList();

    queue.add(mediaItems);
  }

  void filterDeletedFiles() {
    _playlist = _playlist
        .where((item) => File(item.path).existsSync())
        .toList();
    if (_playlist.isEmpty) {
      _currentIndex = 0;
    } else {
      _currentIndex = _currentIndex.clamp(0, _playlist.length - 1);
    }
  }

  Future<void> playFile(String path, String title, {int? index}) async {
    if (index != null && _playlist.isNotEmpty) {
      _currentIndex = index.clamp(0, _playlist.length - 1);
    }

    try {
      await _player.setAudioSource(AudioSource.file(path));

      mediaItem.add(
        MediaItem(
          id: path,
          title: title,
          artist: reciterCubit.selectedReciterModel?.name ?? 'غير معروف',
          album: 'القرآن الكريم',
          artUri: Uri.parse('asset://assets/icons/Rifq logo.jpg'),
          duration: _player.duration ?? Duration.zero,
        ),
      );

      await _player.play();
    } catch (e) {
      log('Error playing file: $e');
    }
  }

  @override
  Future<void> skipToNext() async {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    final item = _playlist[_currentIndex];
    await playFile(item.path, item.title, index: _currentIndex);
  }

  @override
  Future<void> skipToPrevious() async {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    final item = _playlist[_currentIndex];
    await playFile(item.path, item.title, index: _currentIndex);
  }

  @override
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e, st) {
      log('Error during pause: $e\n$st');
    }
  }

  @override
  Future<void> play() async {
    try {
      if (_player.audioSource == null && _playlist.isNotEmpty) {
        final item = _playlist[_currentIndex];
        await playFile(item.path, item.title, index: _currentIndex);
      } else {
        await _player.play();
      }
    } catch (e, st) {
      log('Error during play: $e\n$st');
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e, st) {
      log('Error during stop: $e\n$st');
    }
  }

  @override
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e, st) {
      log('Error during seek: $e\n$st');
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    await _player.dispose();
    return super.onTaskRemoved();
  }

  AudioProcessingState _transformState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  AudioPlayer get player => _player;
  bool _wasPlayingBeforePause = false;

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;

    await session.configure(
      const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,

        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.media,
        ),
        androidWillPauseWhenDucked: false,
      ),
    );

    session.interruptionEventStream.listen((event) async {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            await _player.setVolume(0.3);
            break;
          case AudioInterruptionType.pause:
            _wasPlayingBeforePause = _player.playing;
            await pause();
            break;
          default:
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            await _player.setVolume(1.0);
            break;
          case AudioInterruptionType.pause:
            if (_wasPlayingBeforePause) await _player.play();
            break;
          default:
            break;
        }
      }
    });
  }
}
