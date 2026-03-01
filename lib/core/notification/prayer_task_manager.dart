import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sakina_app/core/notification/prayer_model.dart';
import 'package:sakina_app/core/notification/prayer_foreground_service_note.dart';

class PrayerTask extends TaskHandler {
  List<PrayerNoteModel> prayers = [];

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Start the foreground service with timer updates
    PrayerForegroundManager.startService(prayers);
  }

  @override
  void onRepeatEvent(DateTime timestamp) async {
    // This is now handled by the timer in PrayerForegroundManager
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    // Stop the timer and service
    PrayerForegroundManager.stopService();
    print(
      'Prayer foreground task destroyed at $timestamp, timeout: $isTimeout',
    );
  }
}
