import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZekrItemHeader extends StatelessWidget {
  const ZekrItemHeader({required this.count, required this.zekr, super.key});
  final int count;
  final String zekr;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            zekr,
            maxLines: 2,
            textAlign: TextAlign.right,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
