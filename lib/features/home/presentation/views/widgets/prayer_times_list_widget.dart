import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimesList extends StatelessWidget {
  final PrayerTimes prayerTimes;
  final String? currentPrayerName;

  const PrayerTimesList({
    required this.prayerTimes,
    super.key,
    this.currentPrayerName,
  });

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.jm();

    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: buildPrayerTime(
                'الفجر',
                format.format(prayerTimes.fajr.toLocal()),
              ),
            ),
            Expanded(
              child: buildPrayerTime(
                'الشروق',
                format.format(prayerTimes.sunrise.toLocal()),
              ),
            ),
            Expanded(
              child: buildPrayerTime(
                'الظهر',
                format.format(prayerTimes.dhuhr.toLocal()),
              ),
            ),
            Expanded(
              child: buildPrayerTime(
                'العصر',
                format.format(prayerTimes.asr.toLocal()),
              ),
            ),
            Expanded(
              child: buildPrayerTime(
                'المغرب',
                format.format(prayerTimes.maghrib.toLocal()),
              ),
            ),
            Expanded(
              child: buildPrayerTime(
                'العشاء',
                format.format(prayerTimes.isha.toLocal()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPrayerTime(String name, String time) {
    final isCurrentPrayer =
        currentPrayerName != null &&
        (currentPrayerName!.contains(name) ||
            name.contains(currentPrayerName!.replaceAll('صلاة ', '')));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          getPrayerIcon(name),
          color: const Color(0xFF2D7A5E),
          size: 20.h,
        ),
        SizedBox(height: 2.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 10.sp,
            color: isCurrentPrayer ? const Color(0xFF2D7A5E) : Colors.grey,
            fontWeight: isCurrentPrayer ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          time,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData getPrayerIcon(String name) {
    switch (name) {
      case 'الفجر':
        return Icons.wb_twilight;
      case 'الشروق':
        return Icons.wb_sunny;
      case 'الظهر':
        return Icons.wb_sunny_outlined;
      case 'العصر':
        return Icons.wb_cloudy;
      case 'المغرب':
        return Icons.brightness_3;
      case 'العشاء':
        return Icons.nightlight;
      default:
        return Icons.access_time;
    }
  }
}
