import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_images/app_images.dart';
import 'package:sakina_app/features/quran/data/surah_data.dart';
import 'package:sakina_app/features/quran/models/surah_model.dart';
import 'package:sakina_app/features/quran/presentation/views/surah_details_view.dart';

class AyahCardWidget extends StatelessWidget {
  final String ayahText;
  final String surahName;
  final String ayahNumber;

  const AyahCardWidget({
    required this.ayahNumber,
    required this.ayahText,
    required this.surahName,
    super.key,
  });

  String truncateAyah(String text) {
    const int maxChars = 90;
    if (text.length <= maxChars) return text;

    final int lastSpaceIndex = text.lastIndexOf(' ', maxChars);
    if (lastSpaceIndex == -1) {
      return '${text.substring(0, maxChars)}...';
    }

    return '${text.substring(0, lastSpaceIndex).trim()}...';
  }

  // Find Surah by name from the surahs list
  Surah? findSurahByName(String surahName) {
    try {
      return surahsList.firstWhere(
        (surah) => surah.name.contains(surahName) || surahName.contains(surah.name),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      // Dark mode design
      return GestureDetector(
        onTap: () {
          final surah = findSurahByName(surahName);
          if (surah != null) {
            final ayahNum = int.tryParse(ayahNumber) ?? 1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahDetailsView(
                  surah: surah,
                  ayahNumber: ayahNum,
                ),
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0E3B2E),
                Color(0xFF0A2F25),
              ],
            ),
            border: Border.all(
              color: Color(0xFF1F6F54).withOpacity(.4),
            ),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ⭐ Icon
            CircleAvatar(
              radius: 18.r,
              backgroundColor: const Color(0xFF1F6F54),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 18.sp,
              ),
            ),

            SizedBox(height: 4.h),

            /// عنوان
            Text(
              'آية اليوم',
              style: TextStyle(
                color: const Color(0xFFB7E4C7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 4.h),

            Divider(
              indent: 60.w,
              endIndent: 60.w,
              color: Colors.white.withOpacity(.15),
              thickness: 1,
            ),

            SizedBox(height: 4.h),

            /// نص الآية
            Text(
              '﴿ ${truncateAyah(ayahText)} ﴾',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontFamily: 'Amiri',
                height: 1.7,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4.h),

            Divider(
              indent: 60.w,
              endIndent: 60.w,
              color: Colors.white.withOpacity(.15),
              thickness: 1,
            ),

            SizedBox(height: 4.h),

            /// اسم السورة
            Text(
              'سورة $surahName - آية $ayahNumber',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        ),
      );
    } else {
      // Light mode design - fixed overflow
      return GestureDetector(
        onTap: () {
          final surah = findSurahByName(surahName);
          if (surah != null) {
            final ayahNum = int.tryParse(ayahNumber) ?? 1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahDetailsView(
                  surah: surah,
                  ayahNumber: ayahNum,
                ),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: SizedBox(
            height: 170.h,
            width: double.infinity,
            child: Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: 170.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    image: DecorationImage(
                      image: AssetImage(AppImages.ayahCard),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                // Content
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xffD4AF37),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'آية اليوم',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Divider(
                          indent: 70.w,
                          endIndent: 70.w,
                          color: Colors.blueGrey,
                          thickness: 1.w,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '﴿ ${truncateAyah(ayahText)} ﴾',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Amiri',
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(
                          indent: 70.w,
                          endIndent: 70.w,
                          color: Colors.blueGrey,
                          thickness: 1.w,
                        ),
                        Text(
                          'سورة $surahName - آية $ayahNumber',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
