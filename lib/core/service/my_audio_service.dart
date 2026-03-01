import 'dart:developer';

import 'package:just_audio/just_audio.dart';

class MyAudioService {
  MyAudioService._internal();

  static final MyAudioService instance = MyAudioService._internal();

  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> playSurah({required String url}) async {
    try {
      await _player.setFilePath(url);
      await _player.play();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pauseSurah() async {
    await _player.pause();
  }

  Future<void> stopSurah() async {
    await _player.stop();
  }

  Future<void> toggle() async {
    if (_player.playing) {
      await pauseSurah();
    } else {
      await _player.play();
    }
  }

  Future<void> seekSurahPosition(Duration position) async {
    await _player.seek(position);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<bool> get playingStream => _player.playingStream;
}
