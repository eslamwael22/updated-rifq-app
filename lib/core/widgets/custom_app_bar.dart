import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/widgets/custom_app_container.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.isShow,
    required this.subTitle,
    required this.title,
    super.key,
  });

  final String title;
  final String subTitle;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final textColor = isDark
        ? DarkAppColors.textPrimary
        : LightAppColors.whiteColor;
    final subTextColor = isDark
        ? DarkAppColors.textSecondary
        : const Color.fromRGBO(255, 255, 255, 0.85);
    return CustomAppBarContainer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h, right: 16.w, top: 8.h),
          child: Column(
            children: [
              SizedBox(width: 10.w),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: textColor,
                      size: 25.sp,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: AppStyles.textMedium24(context).copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    isShow
                        ? Icon(
                            Icons.location_on_outlined,
                            color: subTextColor,
                            size: 18.sp,
                          )
                        : SizedBox(width: 30.w),

                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.right,
                          style: AppStyles.textRegular16(context).copyWith(
                            color: subTextColor,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
