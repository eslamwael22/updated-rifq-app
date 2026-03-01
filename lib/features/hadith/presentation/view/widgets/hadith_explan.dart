import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class HadithExplanation extends StatelessWidget {
  const HadithExplanation({
    required this.explanation,
    required this.isDark,
    super.key,
  });
  final String explanation;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      explanation,
      textAlign: TextAlign.right,
      style: AppStyles.textBold15(
        context,
      ).copyWith(color: isDark ? Colors.white : DarkAppColors.avatarBackground),
    );
  }
}
