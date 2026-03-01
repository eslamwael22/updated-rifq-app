import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_state.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_audio_item.dart';

class AudioList extends StatelessWidget {
  const AudioList({
    required this.isDark,
    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CustomAudioQuranItem(
                      isDark: isDark,
                      surahName: SurahModel.surahList[index].name,
                      index: index,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(
                    begin: 0.5,
                    end: 0.0,
                    curve: Curves.easeOut,
                    duration: 400.ms,
                  )
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeOut,
                    duration: 400.ms,
                  )
                  .then(delay: (index * 50).ms);
            },
            childCount: SurahModel.surahList.length,
          ),
        );
      },
    );
  }
}
