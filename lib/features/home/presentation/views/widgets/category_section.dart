import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/quran/presentation/views/quran_view.dart';
import 'package:sakina_app/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:sakina_app/features/qibla_direction/presentation/views/qibla_direction_view.dart';
import 'package:sakina_app/features/qibla_direction/presentation/manager/qibla_cubit.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const CategorySection({
    required this.title,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),

        SizedBox(height: 12.h),

        // Horizontal List
        SizedBox(
          height: 130.h,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: 130.w,

                margin: EdgeInsets.only(left: 13.w),
                child: InkWell(
                  onTap: () {
                    switch (item['title']) {
                      case 'المصحف':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranView(),
                          ),
                        );
                        break;
                      case 'الأذان':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrayerTimesView(),
                          ),
                        );
                        break;

                      case 'المسبحة':
                        Navigator.pushNamed(context, AppRoutes.tasbihView);
                        break;
                      case 'الاربعين النوويه':
                        Navigator.pushNamed(context, AppRoutes.hadithView);
                        break;

                      case 'اتجاه القبلة':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => QiblaCubit(),
                              child: const QiblaDirectionView(),
                            ),
                          ),
                        );
                        break;
                      case 'الرقيه الشرعيه':
                        Navigator.pushNamed(
                          context,
                          AppRoutes.riquatShareiaView,
                        );
                        break;
                      case 'أسماء الله الحسني':
                        Navigator.pushNamed(
                          context,
                          AppRoutes.godNamesCategoryView,
                        );
                        break;
                    }
                  },
                  child: CategoryCard(
                    title: item['title'],
                    subtitle: item['subtitle'],
                    icon: item['icon'],
                    color: item['color'],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(13.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24.h,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            // Title
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: AppStyles.textBold15(context),
                textAlign: TextAlign.right,
              ),
            ),

            const SizedBox(height: 4),

            // Subtitle
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
