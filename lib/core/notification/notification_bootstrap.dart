// notification_bootstrap.dart
import 'dart:developer';
import 'package:sakina_app/core/notification/adhan_notification.dart';
import 'package:sakina_app/core/notification/azkar_notification_service.dart';
import 'package:sakina_app/core/notification/moring_evening_zakar_notification.dart';
import 'package:sakina_app/core/notification/prayer_foreground_service_note.dart';
import 'package:sakina_app/core/notification/prayer_model.dart';
import 'package:sakina_app/core/notification/prayer_notification.dart';
import 'package:sakina_app/features/prayer_times/data/prayer_time_service.dart';
import 'package:sakina_app/features/prayer_times/services/prayer_notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationBootstrap {
  static Future<void> initTimeZone() async {
    tz.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    log('Timezone set: ${timezoneInfo.identifier}');
  }

  static Future<void> init() async {
    await Future.wait([
      AdhanNotification.createChannel(),
      AzkarNotificationService.createChannels(),
      MorningEveningAzkarNotification.createChannel(),
      PrayerNotification.createPrayerChannel(),
    ]);

    final service = PrayerTimeService();
    final times = await service.getPrayerTimes();

    if (times != null) {
      final allPrayers = [
        PrayerNoteModel(name: 'الفجر', dateTime: times.fajr),
        PrayerNoteModel(name: 'الظهر', dateTime: times.dhuhr),
        PrayerNoteModel(name: 'العصر', dateTime: times.asr),
        PrayerNoteModel(name: 'المغرب', dateTime: times.maghrib),
        PrayerNoteModel(name: 'العشاء', dateTime: times.isha),
      ];

      Future.delayed(const Duration(seconds: 1), () async {
        await PrayerForegroundManager.startService(allPrayers);
      });
    }

    final timesList = await service.getPrayerTimesForRange();
    if (timesList.isNotEmpty) {
      await PrayerNotificationService.scheduleEnabledNotificationsForRange(
        timesList,
      );
    }
  }
}
