import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomContainerDecorate extends StatelessWidget {
  const CustomContainerDecorate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.00),
          end: Alignment(1.00, 1.00),
          colors: const [
            LightAppColors.primaryColor,
            LightAppColors.secondColor,
          ],
        ),
      ),
    );
  }
}
