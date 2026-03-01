import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';

class CustomSettingsItemContainer extends StatelessWidget {
  const CustomSettingsItemContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isDark ? DarkAppColors.surface : LightAppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: const Color.fromRGBO(13, 126, 94, 0.12),
          ),
        ),
        shadows: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.10),
            blurRadius: 2.r,
            offset: Offset(0, 1.h),
            spreadRadius: -1.r,
          ),
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.12),
            blurRadius: 3.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: child,
    );
  }
}
