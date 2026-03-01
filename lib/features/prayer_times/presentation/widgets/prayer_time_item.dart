import 'package:flutter/material.dart';
import 'package:sakina_app/features/prayer_times/presentation/widgets/active_card.dart';
import 'package:sakina_app/features/prayer_times/presentation/widgets/normal_prayer.dart';
import 'package:sakina_app/core/notification/adhan_notification.dart';

class PrayerTimeRow extends StatelessWidget {
  final String prayerName;
  final String time;
  final IconData icon;
  final bool isActive;
  final String? remainingTime;
  final PrayerType prayerType;
  final bool isNotificationEnabled;
  final VoidCallback? onNotificationToggle;

  const PrayerTimeRow({
    required this.prayerName,
    required this.time,
    required this.icon,
    required this.prayerType,
    super.key,
    this.isActive = false,
    this.isNotificationEnabled = true,
    this.remainingTime,
    this.onNotificationToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return ActiveCard(
        icon: icon,
        isActive: isActive,
        prayerName: prayerName,
        time: time,
        remainingTime: remainingTime ?? '',
      );
    }
    return NormalPrayer(
      icon: icon,
      isActive: isActive,
      prayerName: prayerName,
      time: time,
      prayerType: prayerType,
      isNotificationEnabled: isNotificationEnabled,
      onNotificationToggle: onNotificationToggle,
    );
  }
}
