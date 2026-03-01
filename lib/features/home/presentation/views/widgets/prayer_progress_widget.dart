import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class PrayerProgress extends StatefulWidget {
  final PrayerTimes? prayerTimes;
  
  const PrayerProgress({super.key, this.prayerTimes});

  @override
  State<PrayerProgress> createState() => _PrayerProgressState();
}

class _PrayerProgressState extends State<PrayerProgress> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double calculateProgress() {
    if (widget.prayerTimes == null) return 0.0;
    
    final now = DateTime.now();
    final current = widget.prayerTimes!.currentPrayer(date: now);
    final next = widget.prayerTimes!.nextPrayer(date: now);
    
    final currentTime = widget.prayerTimes!.timeForPrayer(current);
    final nextTime = widget.prayerTimes!.timeForPrayer(next);
    
    final totalDuration = nextTime.difference(currentTime).inSeconds;
    final elapsedDuration = now.difference(currentTime).inSeconds;
    
    if (totalDuration <= 0) return 0.0;
    if (elapsedDuration >= totalDuration) return 1.0;
    
    return elapsedDuration / totalDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: calculateProgress(),
            backgroundColor: Colors.grey[200],
            color: const Color(0xFF2D7A5E),
            minHeight: 6.h,
          ),
        ),
      ],
    );
  }
}
