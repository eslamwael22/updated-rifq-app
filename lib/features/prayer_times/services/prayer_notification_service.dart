import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakina_app/core/notification/adhan_notification.dart';
import 'package:adhan_dart/adhan_dart.dart';

class PrayerNotificationService {
  static const String _prefix = 'adhan_enabled_';

  // Save notification state for each prayer
  static Future<void> setNotificationEnabled(
    PrayerType prayer,
    bool enabled,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefix${prayer.name}', enabled);
  }

  // Get notification state for each prayer
  static Future<bool> isNotificationEnabled(PrayerType prayer) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_prefix${prayer.name}') ?? true; // Default: enabled
  }

  // Get all notification states
  static Future<Map<PrayerType, bool>> getAllNotificationStates() async {
    final prefs = await SharedPreferences.getInstance();
    final states = <PrayerType, bool>{};

    for (final prayer in PrayerType.values) {
      states[prayer] = prefs.getBool('$_prefix${prayer.name}') ?? true;
    }

    return states;
  }

  // Schedule notifications only for enabled prayers
  static Future<void> scheduleEnabledNotifications(PrayerTimes times) async {
    await AdhanNotification.notification.cancelAll();
    await AdhanNotification.createChannel();

    final states = await getAllNotificationStates();
    final now = DateTime.now();

    // #region agent log
    try {
      final logLine = jsonEncode({
        'id': 'log_${DateTime.now().millisecondsSinceEpoch}_scheduleEnabled',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'location': 'prayer_notification_service.dart:33',
        'message': 'scheduleEnabledNotifications invoked',
        'runId': 'pre-fix',
        'hypothesisId': 'H1',
        'data': {
          'now': now.toIso8601String(),
          'states': {
            for (final entry in states.entries) entry.key.name: entry.value,
          },
          'prayerTimes': {
            'fajr': times.fajr.toIso8601String(),
            'dhuhr': times.dhuhr.toIso8601String(),
            'asr': times.asr.toIso8601String(),
            'maghrib': times.maghrib.toIso8601String(),
            'isha': times.isha.toIso8601String(),
          },
        },
      });
      File(
        'c:\\Users\\20101\\Downloads\\rifq_app-main\\.cursor\\debug.log',
      ).writeAsStringSync('$logLine\n', mode: FileMode.append, flush: true);
    } catch (_) {}
    // #endregion agent log

    final prayers = [
      (PrayerType.fajr, times.fajr, 1),
      (PrayerType.dhuhr, times.dhuhr, 2),
      (PrayerType.asr, times.asr, 3),
      (PrayerType.maghrib, times.maghrib, 4),
      (PrayerType.isha, times.isha, 5),
    ];

    for (final (prayer, time, id) in prayers) {
      if (states[prayer] == true && time.isAfter(now)) {
        await AdhanNotification.scheduleAdhan(
          dateTime: time,
          prayer: prayer,
          id: id,
        );
      }
    }
  }

  // Schedule notifications for multiple days ahead
  static Future<void> scheduleEnabledNotificationsForRange(
    List<PrayerTimes> timesList,
  ) async {
    if (timesList.isEmpty) return;

    await AdhanNotification.notification.cancelAll();
    await AdhanNotification.createChannel();

    final states = await getAllNotificationStates();
    final now = DateTime.now();

    // #region agent log
    try {
      final logLine = jsonEncode({
        'id': 'log_${DateTime.now().millisecondsSinceEpoch}_scheduleRange',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'location': 'prayer_notification_service.dart:100',
        'message': 'scheduleEnabledNotificationsForRange invoked',
        'runId': 'pre-fix',
        'hypothesisId': 'H3',
        'data': {
          'now': now.toIso8601String(),
          'days': timesList.length,
          'states': {
            for (final entry in states.entries) entry.key.name: entry.value,
          },
        },
      });
      File(
        'c:\\Users\\20101\\Downloads\\rifq_app-main\\.cursor\\debug.log',
      ).writeAsStringSync('$logLine\n', mode: FileMode.append, flush: true);
    } catch (_) {}
    // #endregion agent log

    for (int dayIndex = 0; dayIndex < timesList.length; dayIndex++) {
      final times = timesList[dayIndex];
      final baseId = (dayIndex + 1) * 10;

      final prayers = [
        (PrayerType.fajr, times.fajr, baseId + 1),
        (PrayerType.dhuhr, times.dhuhr, baseId + 2),
        (PrayerType.asr, times.asr, baseId + 3),
        (PrayerType.maghrib, times.maghrib, baseId + 4),
        (PrayerType.isha, times.isha, baseId + 5),
      ];

      for (final (prayer, time, id) in prayers) {
        if (states[prayer] == true && time.isAfter(now)) {
          await AdhanNotification.scheduleAdhan(
            dateTime: time,
            prayer: prayer,
            id: id,
          );
        }
      }
    }
  }

  // Toggle notification for specific prayer
  static Future<void> toggleNotification(
    PrayerType prayer,
    PrayerTimes times,
  ) async {
    final currentState = await isNotificationEnabled(prayer);
    await setNotificationEnabled(prayer, !currentState);
    await scheduleEnabledNotifications(times);
  }
}
