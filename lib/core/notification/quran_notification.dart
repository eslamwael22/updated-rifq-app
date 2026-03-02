import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sakina_app/core/constants/azkar_keys.dart';
import 'package:sakina_app/core/notification/notification_init.dart';
import 'package:timezone/timezone.dart' as tz;

class QuranNotification {
  static final _notification =
      InitNotificationService.flutterLocalNotificationsPlugin;

  static const String dailyWerdChannelId = 'daily_werd_channel';
  static Future<void> createChannel() async {
    final note = _notification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await note?.createNotificationChannel(
      const AndroidNotificationChannel(
        dailyWerdChannelId,
        'Daily Werd',
        description: 'تذكير بالورد اليومي',
        importance: Importance.max,
      ),
    );
  }

  static Future<void> scheduleDailyWerd() async {
    final isExact = await InitNotificationService.isExactAllowed();
    final now = DateTime.now();
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      17,
      5,
    );

    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    await _notification.zonedSchedule(
      id: 600,
      title: '📖 وردك اليومي',
      body: 'لا تنسَ قراءة وردك اليومي اليوم 🤍',
      scheduledDate: scheduledTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          dailyWerdChannelId,
          'Daily Werd',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: isExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexact,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: AzkarKeys.quranAzkar,
    );
  }
}
