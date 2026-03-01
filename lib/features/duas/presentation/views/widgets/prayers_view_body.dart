import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/duas/presentation/views/widgets/prayers_list.dart';

class PrayersViewBody extends StatelessWidget {
  const PrayersViewBody({required this.isDark, super.key});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          isShow: false,
          subTitle: 'اكثر من الدعاء الي الله',
          title: 'الادعية الكريمة',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                PrayersList(
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
