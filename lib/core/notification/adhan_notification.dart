import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sakina_app/core/constants/azkar_keys.dart';
import 'package:sakina_app/core/notification/notification_init.dart';
import 'package:timezone/timezone.dart' as tz;

enum PrayerType { fajr, dhuhr, asr, maghrib, isha }

class AdhanNotification {
  static final notification =
      InitNotificationService.flutterLocalNotificationsPlugin;
  static Future<void> createChannel() async {
    final androidPlugin = notification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        'fajr_channel',
        'Fajr Adhan',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('fagr_adhan'),
      ),
    );

    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        'dhuhr_channel',
        'Dhuhr Adhan',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('public_adhan'),
      ),
    );
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        'asr_channel',
        'Asr Adhan',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('public_adhan'),
      ),
    );

    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        'maghrib_channel',
        'Maghrib Adhan',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('public_adhan'),
      ),
    );
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        'isha_channel',
        'Isha Adhan',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('public_adhan'),
      ),
    );
  }

  static Future<void> scheduleAdhan({
    required DateTime dateTime,
    required PrayerType prayer,
    required int id,
  }) async {
    final isExact = await InitNotificationService.isExactAllowed();
    final chanelId = '${prayer.name.toLowerCase()}_channel';

    try {
      final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
      final logLine = jsonEncode({
        'id': 'log_${DateTime.now().millisecondsSinceEpoch}_scheduleAdhan',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'location': 'adhan_notification.dart:60',
        'message': 'scheduleAdhan invoked',
        'runId': 'pre-fix',
        'hypothesisId': 'H2',
        'data': {
          'prayer': prayer.name,
          'id': id,
          'dateTimeLocal': dateTime.toIso8601String(),
          'scheduledTz': scheduledDate.toIso8601String(),
          'channelId': chanelId,
        },
      });
      File(
        'c:\\Users\\20101\\Downloads\\rifq_app-main\\.cursor\\debug.log',
      ).writeAsStringSync('$logLine\n', mode: FileMode.append, flush: true);
    } catch (_) {}
    // #endregion agent log

    await notification.zonedSchedule(
      id: id,
      title: 'حان الآن موعد الأذان',
      body: prayersMap[prayer.name],
      scheduledDate: tz.TZDateTime.from(dateTime, tz.local),
      androidScheduleMode: isExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexact,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          chanelId,
          'Adhan Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: AzkarKeys.adhanAzkar,
    );
  }

  static Map<String, String> prayersMap = {
    'fajr': 'صلاة الفجر',
    'dhuhr': 'صلاة الظهر',
    'asr': 'صلاة العصر',
    'maghrib': 'صلاة المغرب',
    'isha': 'صلاة العشاء',
  };
}
