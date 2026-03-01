import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateCard extends StatelessWidget {
  final String hijriDate;
  final String meladiDate;
  final String dayName;

  const DateCard({
    required this.meladiDate,
    required this.hijriDate,
    required this.dayName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            dayName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cairo',
            ),
          ),

          SizedBox(height: 6.h),
          Text(
            meladiDate,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),

          SizedBox(height: 10.h),

          Text(
            hijriDate,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
