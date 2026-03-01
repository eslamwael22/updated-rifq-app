import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildStatCard({
  required IconData icon,
  required String number,
  required String label,
  required Color color,
  required BuildContext context,
}) {
  return Container(
    height: 132.h,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(
        color: Theme.of(context).dividerColor.withOpacity(0.3),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 32.h,
        ),
        SizedBox(height: 16.h),
        Text(
          number,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            fontSize: 16.sp,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    ),
  );
}
