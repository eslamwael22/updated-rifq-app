import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    super.key,
    this.borderRadius,
    this.padding,
    this.image,
  });
  final double? padding;
  final double? borderRadius;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: const [
            LightAppColors.greenColor0D7,
            LightAppColors.primaryColor,
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 32),
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
      child: Padding(
        padding: EdgeInsets.all(padding ?? 16),
        child: Icon(
          Icons.location_on_outlined,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
