import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomCircleContainer extends StatelessWidget {
  const CustomCircleContainer({
    super.key,
    this.color,
    this.height,
    this.width,
    this.borderWidth,
    this.opacity,
  });
  final Color? color;
  final double? width;
  final double? height;
  final double? opacity;
  final double? borderWidth;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? .1,
      child: Container(
        width: width ?? 120.w, // Responsive width instead of percentage
        height: height ?? 100.h, // Responsive height instead of percentage
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: borderWidth ?? 4.w,
            color: color ?? LightAppColors.secondColor,
          ),
        ),
      ),
    );
  }
}
