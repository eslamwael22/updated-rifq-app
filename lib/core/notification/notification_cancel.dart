import 'package:sakina_app/core/notification/notification_init.dart';

class NotificationCancelSetting {
  static final notification =
      InitNotificationService.flutterLocalNotificationsPlugin;

  static Future<void> cancelNotification({required int id}) async {
    await notification.cancel(id: id);
  }

  static Future<void> cancelAllNotification() async {
    await notification.cancelAll();
  }
}
