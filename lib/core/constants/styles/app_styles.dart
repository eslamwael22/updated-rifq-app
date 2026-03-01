import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/constants/styles/size_config.dart';

abstract class AppStyles {
  static Color getColor(BuildContext context, {Color? light, Color? dark}) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return isDark
        ? (dark ?? DarkAppColors.textPrimary)
        : (light ?? LightAppColors.blackColor1A);
  }

  static TextStyle textMedium36(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 36),
      fontWeight: FontWeight.w500,
      height: 1.11,
      letterSpacing: 0.90,
      color: getColor(context),
    );
  }

  static TextStyle textRegular24(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w400,
      height: 1.33,
      color: getColor(context),
    );
  }

  static TextStyle textRegular12(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w400,
      height: 1.33,
      color: getColor(
        context,
        light: LightAppColors.greyColor6B,
        dark: DarkAppColors.textSecondary,
      ),
    );
  }

  static TextStyle textMedium30(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontWeight: FontWeight.w500,
      height: 1.20,
      color: getColor(context),
    );
  }

  static TextStyle textMedium18(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w500,
      height: 1.56,
      color: getColor(context),
    );
  }

  static TextStyle textMedium16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w500,
      height: 1.50,
      color: getColor(context),
    );
  }

  static TextStyle textMedium20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.w500,
      height: 1.40,
      color: getColor(context),
    );
  }

  static TextStyle textRegular20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Amiri',
      fontWeight: FontWeight.w400,
      height: 2,
      color: getColor(context),
    );
  }

  static TextStyle textRegular14(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w400,
      height: 1.43,
      color: getColor(context),
    );
  }

  static TextStyle textRegular16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w400,
      height: 1.50,
      color: getColor(
        context,
        light: LightAppColors.greyColor6B,
        dark: DarkAppColors.textSecondary,
      ),
    );
  }

  static TextStyle textRegular18(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w400,
      height: 1.63,
      color: getColor(context),
    );
  }

  static TextStyle textBold17(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 17),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textBold20Amiri(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.bold,
      fontFamily: 'Amiri',
    );
  }

  static TextStyle textBold15(BuildContext context) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  }

  static TextStyle textRegular16Amiri(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Amiri',
      fontWeight: FontWeight.w400,
      height: 2,
      color: getColor(context),
    );
  }

  static TextStyle textRegular18Amiri(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Amiri',
      fontWeight: FontWeight.w400,
      height: 1.63,
      color: getColor(context),
    );
  }

  static TextStyle textMedium24(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w500,
      height: 1.33,
      color: getColor(context),
    );
  }

  static TextStyle textRegular30(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontFamily: 'Amiri',
      fontWeight: FontWeight.w400,
      height: 1.20,
      color: getColor(context),
    );
  }

  static TextStyle textRegular72(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 72),
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w400,
      height: 1,
      color: getColor(context),
    );
  }

  static TextStyle textMedium12(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      color: getColor(context),
    );
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double fontSize,
  }) {
    final double scaleFactor = getScaleFactor(context);
    final double responsiveSize = scaleFactor * fontSize;

    final double lowerFont = fontSize * .8;
    final double upperFont = fontSize * 1;
    return responsiveSize.clamp(lowerFont, upperFont);
  }

  static double getScaleFactor(context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < SizeConfig.tablet) {
      return width / 1100;
    } else if (width < SizeConfig.desktop) {
      return width / 1300;
    } else {
      return width / 1700;
    }
  }
}
