import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/hadith/data/models/hadith_model/hadith_model.dart';

class CustomNarrator extends StatelessWidget {
  const CustomNarrator({
    required this.isDark,
    required this.hadith,
    super.key,
  });

  final bool isDark;
  final HadithModel hadith;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark
            ? Colors.white.withOpacity(.05)
            : const Color(0xFF0D7E5E).withOpacity(.08),
      ),
      child: Text(
        hadith.narrator ?? '',
        textAlign: TextAlign.right,
        style: AppStyles.textRegular14(context).copyWith(
          height: 1.6,
          letterSpacing: .3,
        ),
      ),
    );
  }
}
