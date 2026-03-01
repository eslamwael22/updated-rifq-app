import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/current_prayer_widget.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/prayer_progress_widget.dart';
import 'package:sakina_app/features/home/presentation/views/widgets/prayer_times_list_widget.dart';
import 'package:sakina_app/features/prayer_times/data/prayer_time_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimesCardWidget extends StatefulWidget {
  const PrayerTimesCardWidget({super.key});

  @override
  State<PrayerTimesCardWidget> createState() => _PrayerTimesCardWidgetState();
}

class _PrayerTimesCardWidgetState extends State<PrayerTimesCardWidget> {
  PrayerTimes? prayerTimes;
  final PrayerTimeService service = PrayerTimeService();
  Timer? _timer;
  Prayer? _currentNextPrayer;

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
    
    // Start timer to update current prayer every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (prayerTimes != null) {
        final next = prayerTimes!.nextPrayer(date: DateTime.now());
        // Only update state if the next prayer has changed
        if (_currentNextPrayer != next) {
          setState(() {
            _currentNextPrayer = next;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> loadPrayerTimes() async {
    final times = await service.getPrayerTimes();
    if (times != null) {
      setState(() {
        prayerTimes = times;
      });
    }
  }

  String getPrayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return 'صلاة الفجر';
      case Prayer.fajrAfter:
        return 'صلاة الفجر';
      case Prayer.sunrise:
        return 'الشروق';
      case Prayer.dhuhr:
        return 'صلاة الظهر';
      case Prayer.asr:
        return 'صلاة العصر';
      case Prayer.maghrib:
        return 'صلاة المغرب';
      case Prayer.isha:
        return 'صلاة العشاء';
      case Prayer.ishaBefore:
        return 'صلاة العشاء';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          CurrentPrayerWidget(prayerTimes: prayerTimes),
          SizedBox(height: 5.h),
          PrayerProgress(prayerTimes: prayerTimes),
          SizedBox(height: 5.h),
          if (prayerTimes != null)
            PrayerTimesList(
              prayerTimes: prayerTimes!,
              currentPrayerName: _currentNextPrayer != null 
                  ? getPrayerName(_currentNextPrayer!) 
                  : getPrayerName(prayerTimes!.nextPrayer(date: DateTime.now())),
            ),
        ],
      ),
    );
  }
   
  Widget _buildPrayerTime(String name, String time) {
    return Column(
      children: [
        Icon(
          _getPrayerIcon(name),
          color: Theme.of(context).colorScheme.primary,
          size: 24.h,
        ),
        SizedBox(height: 4.h),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          time,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  IconData _getPrayerIcon(String name) {
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
