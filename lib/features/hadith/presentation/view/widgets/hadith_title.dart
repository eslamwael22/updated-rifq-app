import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class HadithTitle extends StatelessWidget {
  const HadithTitle({required this.title, required this.isDark, super.key});
  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: AppStyles.textBold20Amiri(context).copyWith(
        color: isDark ? Colors.white : const Color(0xFF0D7E5E),
      ),
    );
  }
}
