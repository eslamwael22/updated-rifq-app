import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/helper/audio_helper.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_state.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_controllers.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_slider.dart';

class CustomAudioBottomSheet extends StatelessWidget {
  const CustomAudioBottomSheet({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final reciterCubit = context.read<ReciterDownloadingCubit>();
    final audioCubit = context.read<AudioCubit>();
    final audioHelper = AudioHelper(
      reciterCubit: reciterCubit,
      audioCubit: audioCubit,
    );

    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        final index = state.currentIndex >= 0 ? state.currentIndex : 0;
        final surah = SurahModel.surahList[index];
        final max = state.duration.inSeconds > 0
            ? state.duration.inSeconds.toDouble()
            : 1.0;
        final value = state.position.inSeconds.clamp(0, max).toDouble();

        return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.teal[900]!, Colors.teal[800]!]
                      : [Colors.white, Colors.teal[50]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(surah.name, style: AppStyles.textMedium24(context)),
                  const SizedBox(height: 12),
                  AudioControls(
                    index: index,
                    isPlaying: state.isPlaying,
                    onPrevious: () async {
                      if (reciterCubit.selectedReciterModel == null) {
                        showCustomSnackBar(
                          context,
                          'يرجى اختيار شيخ أولاً',
                          isError: true,
                        );
                        return;
                      }
                      if (index > 0) {
                        final played = await audioHelper.playSurahByIndex(
                          index - 1,
                        );
                        if (!played) {
                          final msg = await audioHelper.checkAndGetMessage(
                            index - 1,
                          );
                          if (msg.isNotEmpty) {
                            showCustomSnackBar(context, msg, isError: true);
                          }
                        }
                      }
                    },
                    onPlayPause: () async {
                      if (reciterCubit.selectedReciterModel == null) {
                        showCustomSnackBar(
                          context,
                          'يرجى اختيار شيخ أولاً',
                          isError: true,
                        );
                        return;
                      }
                      await audioHelper.handleMainPlay();
                    },
                    onNext: () async {
                      if (reciterCubit.selectedReciterModel == null) {
                        showCustomSnackBar(
                          context,
                          'يرجى اختيار شيخ أولاً',
                          isError: true,
                        );
                        return;
                      }
                      if (index < SurahModel.surahList.length - 1) {
                        final played = await audioHelper.playSurahByIndex(
                          index + 1,
                        );
                        if (!played) {
                          final msg = await audioHelper.checkAndGetMessage(
                            index + 1,
                          );
                          if (msg.isNotEmpty) {
                            showCustomSnackBar(context, msg, isError: true);
                          }
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomAudioSlider(
                    value: value,
                    max: max,
                    onChanged: (val) {
                      audioCubit.seek(Duration(seconds: val.toInt()));
                    },
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(
              begin: 1.0,
              end: 0.0,
              duration: 500.ms,
              curve: Curves.easeOut,
            );
      },
    );
  }
}
