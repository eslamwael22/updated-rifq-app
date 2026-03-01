import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/widgets/custom_bottom_sheet_copy_icon.dart';
import 'package:sakina_app/core/widgets/hadith_explantion.dart';
import 'package:sakina_app/features/hadith/data/models/hadith_model/hadith_model.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/custom_narrator.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/custom_source.dart';

class HadithBottomSheet extends StatelessWidget {
  const HadithBottomSheet({
    required this.hadith,
    required this.isDark,
    super.key,
  });
  final HadithModel hadith;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF162A25) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomNarrator(isDark: isDark, hadith: hadith),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hadith.hadithText ?? '',
                    textAlign: TextAlign.right,
                    style: AppStyles.textBold20Amiri(context).copyWith(
                      color: isDark ? Colors.white : const Color(0xFF0D7E5E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  HadithSourceWidget(
                    isDark: isDark,
                    source: hadith.source ?? '',
                  ),
                  const SizedBox(height: 12),
                  HadithExplanationWidget(
                    explanation: hadith.explanation ?? '',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomBottomSheetCopyIcon(hadith: hadith, isDark: isDark),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
