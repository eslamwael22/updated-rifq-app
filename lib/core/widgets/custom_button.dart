import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    super.key,
    this.onPressed,
    this.style,
    this.borderRadius,
    this.isLoading = false,
  });
  final String title;
  final void Function()? onPressed;
  final TextStyle? style;
  final double? borderRadius;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return isLoading!
        ? SpinKitFadingCircle(
            color: isDark ? Colors.white : DarkAppColors.buttonBackground,
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),

              backgroundColor: LightAppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 100),
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style:
                  style ??
                  AppStyles.textMedium16(context).copyWith(
                    color: LightAppColors.whiteColor,
                  ),
            ),
          );
  }
}
