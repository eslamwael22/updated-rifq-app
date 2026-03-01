// lib/features/quran/presentation/views/widgets/surahs_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/features/quran/models/surah_model.dart';
import 'surah_item.dart';

class SurahsList extends StatelessWidget {
  final List<Surah> surahs;

  const SurahsList({
    required this.surahs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (surahs.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: Text(
            'لا توجد نتائج',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16.sp,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      );
    }
    return Column(
      children: List.generate(
        surahs.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: SurahItem(surah: surahs[index]),
        ),
      ),
    );
  }
}
