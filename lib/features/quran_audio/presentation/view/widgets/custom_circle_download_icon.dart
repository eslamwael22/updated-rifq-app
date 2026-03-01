import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';

class CustomCircleDownloadIcon extends StatelessWidget {
  const CustomCircleDownloadIcon({
    required this.index,
    required this.isDark,
    super.key,
  });

  final int index;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final fileName = SurahModel.surahList[index].fileName;

    return BlocBuilder<ReciterDownloadingCubit, ReciterDownloadingState>(
      builder: (context, state) {
        final cubit = context.read<ReciterDownloadingCubit>();

        final task = cubit.tasks[fileName];

        if (task != null && task.isDownloading) {
          return SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              value: task.progress,
              strokeWidth: 4,
              color: isDark ? DarkAppColors.dividerSoft : null,
            ),
          );
        }

        return const SizedBox(width: 56, height: 56);
      },
    );
  }
}
