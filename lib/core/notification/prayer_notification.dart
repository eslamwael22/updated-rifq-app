import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sakina_app/core/notification/notification_init.dart';

class PrayerNotification {
  static final _notification =
      InitNotificationService.flutterLocalNotificationsPlugin;
  static const String prayerChannelId = 'current_prayer_channel';
  static Future<void> createPrayerChannel() async {
    final android = _notification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        prayerChannelId,
        'Current Prayer',
        description: 'الصلاة الحالية والقادمة',
        importance: Importance.low,
      ),
    );
  }

  static Future<void> showCurrentPrayerNotification(
    String prayerName,
    String prayerTime,
  ) async {
    await _notification.show(
      id: 700,
      title: 'الصلاة الحالية',
      body: '$prayerName - الساعة $prayerTime',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          prayerChannelId,
          'Current Prayer',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          autoCancel: false,
        ),
      ),
    );
  }
}
