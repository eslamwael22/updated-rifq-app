import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';

class SurahNameWithBorder extends StatelessWidget {
  const SurahNameWithBorder({
    required this.surahName,
    super.key,
  });

  final String surahName;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/quran_surah_name_border.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            isDark ? DarkAppColors.border : Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            'سورة $surahName',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
              fontFamily: 'Amiri',
            ),
          ),
        ),
      ),
    );
  }
}
