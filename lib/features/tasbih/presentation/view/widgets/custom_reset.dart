import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/functions/custom_reset_dialog.dart';

class CustomReset extends StatelessWidget {
  const CustomReset({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? DarkAppColors.surface : const Color(0xFFF8F7F4);
    final borderColor = isDark ? DarkAppColors.border : const Color(0x1E0D7E5E);
    final iconColor = isDark
        ? DarkAppColors.textPrimary
        : LightAppColors.blackColor1A;
    final textColor = iconColor;

    return GestureDetector(
      onTap: () => showCustomResetDialog(context),
      child: Container(
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(33554400),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Icon(
                Icons.replay_outlined,
                color: iconColor,
              ),
              const SizedBox(width: 16),
              Text(
                'إعادة تعيين',
                style: AppStyles.textMedium16(
                  context,
                ).copyWith(color: textColor, height: 1.43),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
