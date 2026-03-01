import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuranTopOverlayBar extends StatelessWidget {
  final String currentSurahName;
  final double fontSize;
  final bool showOverlay;
  final Function(double) onFontSizeChanged;
  final VoidCallback onBackTap;
  final VoidCallback onSearchTap;
  final int currentPageNumber;

  const QuranTopOverlayBar({
    required this.currentSurahName,
    required this.fontSize,
    required this.showOverlay,
    required this.onFontSizeChanged,
    required this.onBackTap,
    required this.onSearchTap,
    required this.currentPageNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: showOverlay ? 0 : -180.h,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {}, // Prevent tap from propagating
        child: Container(
          height: 170.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: onBackTap,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Text(
                        currentSurahName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        currentPageNumber.toString(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.format_size, size: 20.w),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 7,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14,
                            ),
                            activeTrackColor: Theme.of(context).primaryColor,
                            inactiveTrackColor: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.3),
                            thumbColor: Theme.of(context).primaryColor,
                          ),
                          child: Slider(
                            value: fontSize,
                            min: 24.0,
                            max: 36.0,
                            divisions: 4,
                            onChanged: onFontSizeChanged,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '${fontSize.toInt()}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
