import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomRiquatItemAction extends StatelessWidget {
  const CustomRiquatItemAction({
    required this.icon,
    required this.isDark,
    super.key,
    this.onPressed,
  });
  final IconData icon;
  final bool isDark;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? DarkAppColors.accentSoft : LightAppColors.blackColor190,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isDark
              ? DarkAppColors.primaryLight
              : LightAppColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
