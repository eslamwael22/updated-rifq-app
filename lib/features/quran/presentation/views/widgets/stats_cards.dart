// lib/features/quran/presentation/views/widgets/stats_cards.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'build_card.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: buildStatCard(
            icon: Icons.menu_book_outlined,
            number: '114',
            label: 'سورة',
            color: const Color(0xFF0B7A5E),
            context: context,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: buildStatCard(
            icon: Icons.star_border,
            number: '6236',
            label: 'آية',
            color: const Color(0xFFdeab1e),
            context: context,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: buildStatCard(
            icon: Icons.bookmark_border,
            number: '604',
            label: 'صفحة',
            color: const Color(0xFF0B7A5E),
            context: context,
          ),
        ),
      ],
    );
  }
}