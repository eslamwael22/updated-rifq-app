import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomOnBoardingDivider extends StatelessWidget {
  const CustomOnBoardingDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 4,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [
            LightAppColors.darkColor.withValues(alpha: 0),
            LightAppColors.greyColor4C,
            LightAppColors.darkColor.withValues(alpha: 0),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33554400),
        ),
      ),
    );
  }
}
