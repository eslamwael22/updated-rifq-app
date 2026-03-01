import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/features/azkar/presentation/view/azkar_view.dart';
import 'package:sakina_app/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/prayer_times_card_widget.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/ayah_card_widget.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/ayah_card_shimmer.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/category_section.dart';
import 'package:sakina_app/features/quran/services/quran_json_service.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/navigation_bar.dart';
import 'package:sakina_app/features/quran/presentation/views/quran_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int currentIndex = -1; // -1 = مفيش تحديد

  void onTabTapped(int index) {
    if (currentIndex == index && index != 0) return;

    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuranView()),
        ).then((_) {
          setState(() {
            currentIndex = -1;
          });
        });
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrayerTimesView()),
        ).then((_) {
          setState(() {
            currentIndex = -1;
          });
        });
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.recitersView);
        setState(() {
          currentIndex = -1;
        });
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AzkarView()),
        ).then((_) {
          setState(() {
            currentIndex = -1;
          });
        });
        break;
    }
  }

  Map<String, String>? todayAyah;

  @override
  void initState() {
    super.initState();
    loadTodayAyah();
  }

  Future<void> loadTodayAyah() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayKey = '${today.day}-${today.month}-${today.year}';

    final cachedAyahText = prefs.getString('ayah_text_$todayKey');
    final cachedAyahSurah = prefs.getString('ayah_surah_$todayKey');
    final cachedAyahNumber = prefs.getString('ayah_number_$todayKey');

    if (cachedAyahText != null &&
        cachedAyahSurah != null &&
        cachedAyahNumber != null) {
      setState(() {
        todayAyah = {
          'text': cachedAyahText,
          'surah': cachedAyahSurah,
          'ayah': cachedAyahNumber,
        };
      });
      return;
    }

    final quranData = await QuranJsonService.loadQuranJson();

    final Random random = Random(today.day + today.month + today.year);
    final int randomPageIndex = random.nextInt(quranData.length);
    final selectedPage = quranData[randomPageIndex];

    final versesBySura = selectedPage['verses_by_sura'] as Map<String, dynamic>;
    final List<Map<String, String>> allAyahs = [];

    versesBySura.forEach((surahName, verses) {
      final versesList = verses as List;
      for (var verse in versesList) {
        allAyahs.add({
          'text': verse['text'] as String,
          'surah': surahName,
          'ayah': verse['index'].toString(),
        });
      }
    });

    if (allAyahs.isNotEmpty) {
      final int randomAyahIndex = random.nextInt(allAyahs.length);
      final selectedAyah = allAyahs[randomAyahIndex];

      await prefs.setString('ayah_text_$todayKey', selectedAyah['text']!);
      await prefs.setString('ayah_surah_$todayKey', selectedAyah['surah']!);
      await prefs.setString('ayah_number_$todayKey', selectedAyah['ayah']!);

      setState(() {
        todayAyah = selectedAyah;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: MainNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
        ),
        body: Stack(
          children: [
            Container(
              height: 440.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? DarkAppColors.card : DarkAppColors.accentGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'رِفْق',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 29.sp,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Cairo',
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              context.watch<ThemeCubit>().state ==
                                      ThemeMode.dark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: Colors.white,
                              size: 24.h,
                            ),
                            onPressed: () {
                              context.read<ThemeCubit>().changeTheme();
                            },
                          ),
                          SizedBox(width: 10.w),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.settingsView,
                              );
                            },
                            icon: const Icon(
                              Icons.settings_outlined,
                              color: Colors.white,
                            ),
                            iconSize: 24.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'السلام عليكم ورحمة الله',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Positioned(
              top: 130.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PrayerTimesCardWidget(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: todayAyah == null
                          ? const AyahCardShimmer()
                          : AyahCardWidget(
                              ayahText: todayAyah!['text']!,
                              surahName: todayAyah!['surah']!,
                              ayahNumber: todayAyah!['ayah']!,
                            ),
                    ),

                    SizedBox(height: 20.h),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: CategorySection(
                        title: 'خدمات إسلامية',
                        items: [
                          {
                            'title': 'الاربعين النوويه',
                            'subtitle': 'نور من السنه',
                            'icon': Icons.auto_stories_rounded,
                            'color': Theme.of(context).colorScheme.primary,
                          },
                          {
                            'title': 'اتجاه القبلة',
                            'subtitle': 'تحديد القبلة',
                            'icon': Icons.navigation,
                            'color': Theme.of(context).colorScheme.primary,
                          },
                          {
                            'title': 'الرقيه الشرعيه',
                            'subtitle': 'شفاء ورحمه',
                            'icon': Icons.volunteer_activism_rounded,
                            'color': Theme.of(context).colorScheme.primary,
                          },
                          {
                            'title': 'المسبحة',
                            'subtitle': 'تسبيح',
                            'icon': Icons.radio_button_checked_rounded,
                            'color': Theme.of(context).colorScheme.primary,
                          },
                          {
                            'title': 'أسماء الله الحسني',
                            'subtitle': 'أسماء الله وصفاته',
                            'icon': Icons.star,
                            'color': Theme.of(context).colorScheme.primary,
                          },
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
