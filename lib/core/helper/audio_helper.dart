import 'dart:io';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/core/service/connection_service.dart';

class AudioHelper {
  final ReciterDownloadingCubit reciterCubit;
  final AudioCubit audioCubit;

  AudioHelper({required this.reciterCubit, required this.audioCubit});

  Future<String?> getLocalPath(int index) async {
    final fileName = SurahModel.surahList[index].fileName;
    final selectedReciter = reciterCubit.selectedReciterModel;
    if (selectedReciter == null) {
      return null;
    }
    final result = await reciterCubit.service.getLocalPath(
      reciterName: selectedReciter.name,
    );

    return await result.fold(
      (failure) async => null,
      (dirPath) async {
        final fullPath = '$dirPath/$fileName.mp3';
        final file = File(fullPath);
        return await file.exists() ? fullPath : null;
      },
    );
  }

  Future<bool> playSurahByIndex(int index) async {
    final path = await getLocalPath(index);
    if (path != null) {
      await audioCubit.playSurah(
        localPath: path,
        index: index,
        reciterName: reciterCubit.selectedReciterModel!.name,
      );
      return true;
    }
    return false;
  }

  Future<void> handleMainPlay() async {
    final state = audioCubit.state;
    final currentIndex = state.currentIndex >= 0 ? state.currentIndex : 0;

    final path = await getLocalPath(currentIndex);
    if (path == null) return;

    await audioCubit.restoreLastPlayback(
      reciterCubit.selectedReciterModel!.name,
    );

    if (state.currentIndex == currentIndex) {
      audioCubit.togglePlayPause();
    } else {
      await audioCubit.playSurah(
        localPath: path,
        index: currentIndex,
        reciterName: reciterCubit.selectedReciterModel!.name,
      );
    }
  }

  Future<String> checkAndGetMessage(int index) async {
    final path = await getLocalPath(index);
    if (path != null) {
      return '';
    }

    final hasConnection = await ConnectionService.hasFullConnection();
    return hasConnection
        ? 'السورة غير محملة، يمكنك تحميلها الآن'
        : 'يجب تحميل السورة أولاً أو التأكد من الإنترنت';
  }
}
