import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/service/connection_service.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/features/quran_audio/data/reciter_model.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_state.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';

class CustomAudioQuranIconsState extends StatelessWidget {
  const CustomAudioQuranIconsState({
    required this.index,
    required this.isDark,
    super.key,
  });

  final int index;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.read<ReciterDownloadingCubit>();
    final audioCubit = context.read<AudioCubit>();
    final surah = SurahModel.surahList[index];
    final fileName = surah.fileName;

    return BlocBuilder<ReciterDownloadingCubit, ReciterDownloadingState>(
      builder: (context, state) {
        final task = reciterCubit.tasks[fileName];
        final isDownloaded = task?.isLoaded ?? false;
        final isDownloading = task?.isDownloading ?? false;
        final selectedReciterName = reciterCubit.selectedReciterModel?.name;
        return BlocBuilder<AudioCubit, AudioState>(
          buildWhen: (previous, current) =>
              previous.currentIndex != current.currentIndex ||
              previous.isPlaying != current.isPlaying ||
              previous.currentReciter != current.currentReciter,
          builder: (context, audioState) {
            final isCurrent =
                audioState.currentIndex == index &&
                audioState.currentReciter == selectedReciterName;
            final isPlaying = isCurrent && audioState.isPlaying;

            Widget iconWidget;

            // تحميل جاري
            if (isDownloading) {
              iconWidget = Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      value: task?.progress ?? 0.0,
                      strokeWidth: 8,
                      color: isDark
                          ? DarkAppColors.dividerSoft
                          : LightAppColors.primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      reciterCubit.cancelDownload(fileName);
                    },
                  ),
                ],
              );
            }
            // تم التحميل
            else if (isDownloaded) {
              iconWidget = IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () async {
                  final selectedReciter = reciterCubit.selectedReciterModel;
                  if (selectedReciter == null) {
                    showCustomSnackBar(
                      context,
                      'يرجى اختيار شيخ أولاً',
                      isError: true,
                    );
                    return;
                  }

                  final reciterModel = ReciterModel(
                    reciterName: selectedReciter.name,
                    reciterUrl:
                        '${selectedReciter.serverUrl}${surah.fileName}.mp3',
                    fileName: surah.fileName,
                    onProgress: (_) {},
                  );

                  final pathResult = await reciterCubit.service.getLocalPath(
                    reciterName: reciterModel.reciterName,
                  );

                  pathResult.fold(
                    (failure) {
                      showCustomSnackBar(
                        context,
                        failure.errorMessage,
                        isError: true,
                      );
                    },
                    (dirPath) async {
                      final fullPath = '$dirPath/${reciterModel.fileName}.mp3';

                      if (isCurrent) {
                        audioCubit.togglePlayPause();
                      } else {
                        await audioCubit.playSurah(
                          localPath: fullPath,
                          reciterName: reciterModel.reciterName,
                          index: index,
                        );
                      }
                    },
                  );
                },
              );
            } else {
              iconWidget = IconButton(
                icon: const Icon(Icons.download, color: Colors.white, size: 28),
                onPressed: () async {
                  final selectedReciter = reciterCubit.selectedReciterModel;
                  if (selectedReciter == null) {
                    showCustomSnackBar(
                      context,
                      'يرجى اختيار شيخ أولاً',
                      isError: true,
                    );
                    return;
                  }

                  if (!await ConnectionService.hasFullConnection()) {
                    showCustomSnackBar(
                      context,
                      'لا يوجد اتصال بالإنترنت',
                      isError: true,
                    );
                    return;
                  }

                  final reciterModel = ReciterModel(
                    reciterName: selectedReciter.name,
                    reciterUrl:
                        '${selectedReciter.serverUrl}${surah.fileName}.mp3',
                    fileName: surah.fileName,
                    onProgress: (_) {},
                  );

                  await reciterCubit.downloadReciter(
                    reciterModel: reciterModel,
                  );
                },
              );
            }

            return Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? DarkAppColors.buttonBackground
                    : LightAppColors.primaryColor,
              ),
              child: Center(child: iconWidget),
            );
          },
        );
      },
    );
  }
}
