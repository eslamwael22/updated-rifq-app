import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class GodNotItemCard extends StatelessWidget {
  const GodNotItemCard({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? DarkAppColors.container : LightAppColors.whiteColor,
        border: Border.all(
          color: isDark
              ? DarkAppColors.primaryLight
              : LightAppColors.primaryColor,

          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? DarkAppColors.glow : LightAppColors.blackColor19D,
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: AppStyles.textMedium20(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
