import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AyahCardShimmer extends StatelessWidget {
  const AyahCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark 
          ? const Color(0xFF0E3B2E)
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1F6F54)
          : Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 160.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF0A2F25)
              : Colors.white,
        ),
      ),
    );
  }
}
