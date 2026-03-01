import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class SplashBackgroundContainer extends StatelessWidget {
  const SplashBackgroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: const [
            LightAppColors.primaryColor,
            LightAppColors.primaryColor,
            LightAppColors.greenColor0D7,
          ],
        ),
        shape: RoundedRectangleBorder(),
      ),
    );
  }
}
