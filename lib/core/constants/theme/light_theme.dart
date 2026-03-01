import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    primaryColor: LightAppColors.primaryColor,
    scaffoldBackgroundColor: LightAppColors.backgroundPrimary,
    colorScheme: ColorScheme.light(
      primary: LightAppColors.primaryColor,
      secondary: LightAppColors.secondColor,
      onSurface: LightAppColors.blackColor1A,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: LightAppColors.blackColor1A),
    ),
  );
}
