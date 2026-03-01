import 'package:flutter/material.dart';
import 'package:sakina_app/core/functions/hadith_bottom_sheet.dart';
import 'package:sakina_app/features/hadith/data/models/hadith_model/hadith_model.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/custom_narrator.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/hadith_title.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({required this.hadith, required this.isDark, super.key});
  final HadithModel hadith;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark
        ? const Color(0xFF162A25)
        : const Color(0xFFE6F4EF);
    final borderColor = isDark
        ? const Color(0xFF2A4B3F)
        : const Color(0xFFBDE3D3);

    final iconColor = isDark
        ? const Color(0xFF2BD498)
        : const Color(0xFF0DA77B);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CustomNarrator(isDark: isDark, hadith: hadith),
          const SizedBox(height: 15),
          HadithTitle(title: hadith.hadithText ?? '', isDark: isDark),
          const SizedBox(height: 15),

          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => HadithBottomSheet(
                  hadith: hadith,
                  isDark: isDark,
                ),
              ),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 22,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
