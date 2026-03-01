// lib/features/quran/presentation/views/widgets/quran_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'search_bar_widget.dart';

class QuranHeader extends StatelessWidget {
  final int surahCount;
  final Function(String) onSearch;

  const QuranHeader({
    required this.surahCount,
    required this.onSearch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Theme.of(context).colorScheme.onPrimary,
                        iconSize: 25.h,
                      ),
                      const Spacer(),
                      Text(
                        'القرآن الكريم',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo',
                            ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '$surahCount سورة',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withOpacity(0.7),
                      fontSize: 13.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: SearchBarWidget(
                onChanged: onSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
