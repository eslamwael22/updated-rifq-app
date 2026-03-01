import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';

class CustomAppBarContainer extends StatelessWidget {
  const CustomAppBarContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(13, 126, 94, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.35),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
