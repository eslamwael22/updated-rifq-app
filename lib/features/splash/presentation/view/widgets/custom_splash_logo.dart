import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomSplashLogo extends StatelessWidget {
  const CustomSplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .22,
      height: MediaQuery.sizeOf(context).height * .11,
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: LightAppColors.secondColor,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/Rifq logo.jpg',

          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
