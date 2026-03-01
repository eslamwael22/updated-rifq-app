import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sakina_app/core/helper/audio_handler.dart';
import 'package:sakina_app/features/quran_audio/data/audio_item_model.dart';
import 'package:sakina_app/features/quran_audio/data/reciter_state_model.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioHandlerHelper audioHandler;
  final ReciterDownloadingCubit reciterCubit;
  final _seekSubject = PublishSubject<double>();
  StreamSubscription? _seekSub;
  AudioCubit(this.audioHandler, this.reciterCubit)
    : super(AudioState.initial()) {
    _listenToPlayback();
  }

  Duration? _lastPosition;
  final Map<String, ReciterPlaybackState> _reciterPlayback = {};

  void _saveCurrentPlayback() {
    final filePath = state.currentFilePath;
    final reciterName = state.currentReciter;

    if (filePath != null && filePath.isNotEmpty && reciterName != null) {
      _reciterPlayback[reciterName] = ReciterPlaybackState(
        filePath: filePath,
        index: state.currentIndex,
        position: state.position,
        reciterName: reciterName,
      );
    }
  }

  Future<void> restoreLastPlayback(String reciterName) async {
    final last = _reciterPlayback[reciterName];

    if (last != null) {
      final file = File(last.filePath);

      if (file.existsSync()) {
        await audioHandler.playFile(
          last.filePath,
          SurahModel.surahList[last.index].name,
          index: last.index,
        );

        await audioHandler.seek(last.position);

        emit(
          state.copyWith(
            isPlaying: true,
            currentFilePath: last.filePath,
            currentIndex: last.index,
            position: last.position,
            currentTitle: SurahModel.surahList[last.index].name,
            currentReciter: last.reciterName,
          ),
        );
      }
    }
  }

  StreamSubscription? _playbackSub;
  StreamSubscription? _mediaItemSub;
  StreamSubscription? _positionSub;

  void _listenToPlayback() {
    _playbackSub = audioHandler.playbackState.listen((playbackState) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isPlaying: playbackState.playing,
            duration: audioHandler.mediaItem.value?.duration ?? Duration.zero,
          ),
        );
      }
    });

    _mediaItemSub = audioHandler.mediaItem.listen((item) {
      if (!isClosed && item != null) {
        final index = SurahModel.surahList.indexWhere(
          (s) => s.name == item.title,
        );
        emit(
          state.copyWith(
            currentTitle: item.title,
            currentFilePath: item.id,
            currentIndex: index >= 0 ? index : state.currentIndex,
          ),
        );
      }
    });

    _positionSub = audioHandler.player.positionStream
        .throttleTime(const Duration(milliseconds: 300))
        .listen((pos) {
          if (!isClosed) emit(state.copyWith(position: pos));
        });
    _seekSub = _seekSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen((value) async {
          await audioHandler.seek(Duration(milliseconds: value.toInt()));
        });
  }

  final Map<String, List<AudioItemModel>> _reciterPlaylists = {};

  Future<void> changeReciter(String reciterName) async {
    if (!_reciterPlaylists.containsKey(reciterName)) {
      await initPlaylist(reciterName);
    }

    await restoreLastPlayback(reciterName);
  }

  Future<void> initPlaylist(String reciterName) async {
    if (_reciterPlaylists.containsKey(reciterName) &&
        _reciterPlaylists[reciterName]!.isNotEmpty) {
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final recitersDir = Directory('${dir.path}/reciters/$reciterName');

    if (!await recitersDir.exists()) await recitersDir.create(recursive: true);

    final files = await recitersDir.list().toList();
    final validItems = <AudioItemModel>[];

    for (final file in files) {
      if (file is File && file.path.endsWith('.mp3')) {
        final fileName = file.uri.pathSegments.last.replaceAll('.mp3', '');
        final surah = SurahModel.surahList.firstWhere(
          (s) => s.fileName == fileName,
          orElse: () => SurahModel.surahList.first,
        );
        validItems.add(AudioItemModel(path: file.path, title: surah.name));
      }
    }

    if (validItems.isEmpty) return;

    _reciterPlaylists[reciterName] = validItems;
    audioHandler.setPlaylist(validItems);
  }

  void clearPlaylist() => audioHandler.setPlaylist([]);

  Future<void> reset() async {
    await audioHandler.stop();
    clearPlaylist();
    emit(AudioState.initial());
  }

  Future<void> playSurah({
    required String localPath,
    required int index,
    required String reciterName,
  }) async {
    final currentReciter = reciterCubit.selectedReciterModel?.name;

    if (state.currentFilePath != null && currentReciter != reciterName) {}

    if (!_reciterPlaylists.containsKey(reciterName)) {
      await changeReciter(reciterName);
    }

    final file = File(localPath);
    if (!file.existsSync()) return;

    final title = SurahModel.surahList[index].name;

    await audioHandler.playFile(localPath, title, index: index);

    if (state.currentIndex == index && _lastPosition != null) {
      await audioHandler.seek(_lastPosition!);
    } else {
      _lastPosition = null;
    }

    _saveCurrentPlayback();

    emit(
      state.copyWith(
        isPlaying: true,
        currentTitle: title,
        currentFilePath: localPath,
        currentIndex: index,
        currentReciter: reciterName,
      ),
    );
  }

  Future<void> togglePlayPause() async {
    if (audioHandler.player.playing) {
      await audioHandler.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      if (audioHandler.player.audioSource == null &&
          audioHandler.queue.value.isNotEmpty) {
        final currentItem = audioHandler.queue.value[audioHandler.currentIndex];
        await audioHandler.playFile(
          currentItem.id,
          currentItem.title,
          index: audioHandler.currentIndex,
        );
      } else {
        await audioHandler.player.play();
      }
      emit(state.copyWith(isPlaying: true));
    }
  }

  Future<void> stop() async {
    await audioHandler.stop();
    emit(state.copyWith(isPlaying: false, position: Duration.zero));
  }

  Future<void> seek(Duration position) async {
    await audioHandler.seek(position);
    emit(state.copyWith(position: position));
  }

  Future<void> skipToNext() async => await audioHandler.skipToNext();
  Future<void> skipToPrevious() async => await audioHandler.skipToPrevious();

  @override
  Future<void> close() async {
    await _playbackSub?.cancel();
    await _mediaItemSub?.cancel();
    await _positionSub?.cancel();
    await _seekSub?.cancel();
    await _seekSubject.close();
    return super.close();
  }
}
