import 'package:flutter/material.dart';
import 'package:sakina_app/features/quran/presentation/views/widgets/surah_name_with_border.dart';

class SurahTitle extends StatelessWidget {
  final String surahName;
  final bool showTitle;

  const SurahTitle({
    required this.surahName,
    required this.showTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!showTitle) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 10),
        SurahNameWithBorder(surahName: surahName),
        const SizedBox(height: 20),
      ],
    );
  }
}
