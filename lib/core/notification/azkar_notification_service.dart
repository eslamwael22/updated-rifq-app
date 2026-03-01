import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sakina_app/core/constants/azkar_keys.dart';
import 'package:sakina_app/core/notification/notification_init.dart';

class AzkarNotificationService {
  static final _notifications =
      InitNotificationService.flutterLocalNotificationsPlugin;
  static const _randomChannelId = 'random_azkar_channel';
  static const _tasbeehChannelId = 'tasbeeh_channel';

  static const List<String> _randomAzkar = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله العلي العظيم',
    'لا اله الا انت سبحانك اني كنت من الظالمين',
    'سبحان الله وبحمده، سبحان الله العظيم',
    'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير',
  ];

  static Future<void> createChannels() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _randomChannelId,
        'Random Azkar',
        description: 'Random Azkar Notifications',
      ),
    );

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _tasbeehChannelId,
        'Tasbeeh',
        description: 'Reminder for Tasbeeh',
      ),
    );
  }

  static Future<void> showRepeatedRandomZikr() async {
    final random = Random();
    final zikr = _randomAzkar[random.nextInt(_randomAzkar.length)];
    await _notifications.periodicallyShow(
      id: 401,
      title: 'دوم علي ذكر الله',
      body: zikr,
      repeatInterval: RepeatInterval.hourly,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _randomChannelId,
          'Random Azkar',
        ),
      ),
      payload: AzkarKeys.tasbihAzkar,
    );
  }

  static Future<void> scheduleTasbih() async {
    await _notifications.periodicallyShowWithDuration(
      id: 402,
      title: 'الصلاة علي النبي',
      body: 'اللهم صلي على سيدنا محمد وعلى آله وصحبه أجمعين',
      repeatDurationInterval: const Duration(hours: 3),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _tasbeehChannelId,
          'Tasbeeh',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: AzkarKeys.tasbihAzkar,
    );
  }
}
