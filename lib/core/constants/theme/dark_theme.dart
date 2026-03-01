import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    primaryColor: DarkAppColors.primaryColor,
    scaffoldBackgroundColor: DarkAppColors.scaffoldBackground,
    colorScheme: ColorScheme.dark(
      primary: DarkAppColors.primaryColor,
      secondary: DarkAppColors.accentGold,
      surface: DarkAppColors.surface,
      onPrimary: DarkAppColors.textPrimary,
      onSurface: DarkAppColors.textPrimary,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: DarkAppColors.textPrimary),
    ),
  );
}
