import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomRiquatLimitNum extends StatelessWidget {
  const CustomRiquatLimitNum({
    required this.isDark,
    required this.model,
    super.key,
  });

  final bool isDark;
  final String model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .1,
      width: MediaQuery.sizeOf(context).width * .1,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? DarkAppColors.primaryLight
            : LightAppColors.primaryColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(
            child: Text(
              model,
              style:
                  AppStyles.textRegular24(
                    context,
                  ).copyWith(
                    color: isDark ? Colors.white : LightAppColors.primaryColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
