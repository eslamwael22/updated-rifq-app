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
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, 17);
    await _notification.zonedSchedule(
      id: 600,
      title: '📖 وردك اليومي',
      body: 'لا تنسَ قراءة وردك اليومي اليوم 🤍',
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          dailyWerdChannelId,
          'Daily Werd',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: AzkarKeys.quranAzkar,
    );
  }
}
