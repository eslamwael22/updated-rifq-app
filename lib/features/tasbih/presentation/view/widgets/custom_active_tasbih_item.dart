import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomActiveTasbihItem extends StatelessWidget {
  const CustomActiveTasbihItem({required this.tasbihName, super.key});
  final String tasbihName;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: ShapeDecoration(
        color: isDark ? const Color.fromRGBO(18, 48, 40, 1) : null,
        gradient: isDark
            ? null
            : const LinearGradient(
                begin: Alignment(0.5, 0),
                end: Alignment(0.5, 1),
                colors: [
                  LightAppColors.greyColorE8,
                  Colors.white,
                ],
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            width: 2.w,
            color: const Color.fromRGBO(13, 126, 94, 1),
          ),
        ),
        shadows: isDark
            ? [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.35),
                  blurRadius: 12.r,
                  offset: Offset(0, 6.h),
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0x19000000),
                  blurRadius: 6.r,
                  offset: Offset(0, 4.h),
                  spreadRadius: -4.r,
                ),
                BoxShadow(
                  color: const Color(0x19000000),
                  blurRadius: 15.r,
                  offset: Offset(0, 10.h),
                  spreadRadius: -3.r,
                ),
              ],
      ),
      child: Stack(
        children: [
          if (isDark)
            Positioned(
              top: -20.h,
              left: -20.w,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: const [
                      Color.fromRGBO(13, 126, 94, 0.25),
                      Color.fromRGBO(13, 126, 94, 0),
                    ],
                  ),
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(8.r),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        tasbihName,
                        style: AppStyles.textRegular18(context).copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(13, 126, 94, 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
