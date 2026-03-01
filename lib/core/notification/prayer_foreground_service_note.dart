import 'dart:async';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sakina_app/core/notification/get_next_prayer.dart';
import 'package:sakina_app/core/notification/prayer_model.dart';
import 'package:sakina_app/core/notification/prayer_notification.dart';
import 'package:sakina_app/core/notification/prayer_task_manager.dart';

class PrayerForegroundManager {
  static Timer? _updateTimer;
  
  static Future<void> startService([List<PrayerNoteModel>? prayers]) async {
    prayers ??= [];
    if (prayers.isEmpty) return;
    
    // Request notification permission (Android 13+)
    await FlutterForegroundTask.requestNotificationPermission();
    
    // Initialize foreground task
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: PrayerNotification.prayerChannelId,
        channelName: 'Current Prayer',
        channelDescription: 'الصلاة الحالية والقادمة',
        playSound: true,
        channelImportance: NotificationChannelImportance.MAX,
        priority: NotificationPriority.MAX,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        autoRunOnBoot: true,
        eventAction: ForegroundTaskEventAction.repeat(60000),
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
    );

    // Start the foreground service
    await FlutterForegroundTask.startService(
      notificationTitle: 'مواقيت الصلاة',
      notificationText: 'جاري حساب الصلاة القادمة...',
      callback: startCallback,
    );

    // Initial update
    await _updateNotification(prayers);

    // Update every minute (not every second to save battery)
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await _updateNotification(prayers);
    });
  }

  static Future<void> _updateNotification(List<PrayerNoteModel>? prayers) async {
    if (prayers == null || prayers.isEmpty) return;
    final notificationText = await getNextPrayerText(prayers);
    await FlutterForegroundTask.updateService(
      notificationText: notificationText,
    );
  }

  static Future<void> stopService() async {
    _updateTimer?.cancel();
    await FlutterForegroundTask.stopService();
  }

  @pragma('vm:entry-point')
  static void startCallback() {
    FlutterForegroundTask.setTaskHandler(PrayerTask());
  }
}
