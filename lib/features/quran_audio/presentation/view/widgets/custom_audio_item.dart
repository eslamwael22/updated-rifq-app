import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_audio_quran_icons_states.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/widgets/custom_audio_quran_number.dart';
import 'package:sakina_app/features/settings/presentation/view/widgets/custom_settings_item_container.dart';

class CustomAudioQuranItem extends StatelessWidget {
  const CustomAudioQuranItem({
    required this.index,
    required this.isDark,
    required this.surahName,
    super.key,
  });

  final bool isDark;
  final String surahName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomSettingsItemContainer(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CustomAudioQuranNumber(isDark: isDark, index: index),
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                surahName,
                style: AppStyles.textRegular16(context),
              ),
            ),

            CustomAudioQuranIconsState(index: index, isDark: isDark),
          ],
        ),
      ),
    );
  }
}
