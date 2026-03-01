import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_images/app_images.dart';
import 'package:sakina_app/features/prayer_times/presentation/widgets/prayer_time_item.dart';
import 'package:sakina_app/features/prayer_times/services/prayer_notification_service.dart';
import 'package:sakina_app/features/prayer_times/data/prayer_time_service.dart';
import '../widgets/city_card.dart';
import '../widgets/date_card.dart';
import 'package:sakina_app/core/notification/adhan_notification.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({super.key});

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  PrayerTimes? prayerTimes;
  String cityName = 'جاري تحديد الموقع...';
  final PrayerTimeService service = PrayerTimeService();
  Map<PrayerType, bool> notificationStates = {};

  Future<void> scheduleAllAdhan(PrayerTimes times) async {
    await AdhanNotification.notification.cancelAll();
    await AdhanNotification.createChannel();

    final now = DateTime.now();

    if (times.fajr.isAfter(now)) {
      await AdhanNotification.scheduleAdhan(
        dateTime: times.fajr,
        prayer: PrayerType.fajr,
        id: 1,
      );
    }

    if (times.dhuhr.isAfter(now)) {
      await AdhanNotification.scheduleAdhan(
        dateTime: times.dhuhr,
        prayer: PrayerType.dhuhr,
        id: 2,
      );
    }

    if (times.asr.isAfter(now)) {
      await AdhanNotification.scheduleAdhan(
        dateTime: times.asr,
        prayer: PrayerType.asr,
        id: 3,
      );
    }

    if (times.maghrib.isAfter(now)) {
      await AdhanNotification.scheduleAdhan(
        dateTime: times.maghrib,
        prayer: PrayerType.maghrib,
        id: 4,
      );
    }

    if (times.isha.isAfter(now)) {
      await AdhanNotification.scheduleAdhan(
        dateTime: times.isha,
        prayer: PrayerType.isha,
        id: 5,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    loadPrayerTimes();
    loadCityName();
  }

  Future<void> loadCityName() async {
    final name = await service.getCityName();
    if (mounted) {
      setState(() {
        cityName = name;
      });
    }
  }

  Future<void> loadPrayerTimes() async {
    final times = await service.getPrayerTimes();

    if (times == null) {
      // ✅ لو مفيش permission، اعرض رسالة
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('من فضلك اسمح بالوصول للموقع لحساب مواقيت الصلاة'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      return;
    }

    // Load notification states
    final states = await PrayerNotificationService.getAllNotificationStates();

    setState(() {
      prayerTimes = times;
      notificationStates = states;
    });
    await PrayerNotificationService.scheduleEnabledNotifications(times);
  }

  Future<void> _toggleNotification(PrayerType prayerType) async {
    if (prayerTimes != null) {
      await PrayerNotificationService.toggleNotification(
        prayerType,
        prayerTimes!,
      );

      // Update notification states
      final newStates =
          await PrayerNotificationService.getAllNotificationStates();

      setState(() {
        notificationStates = newStates;
      });
    }
  }

  List<Widget> buildPrayerList() {
    final format = DateFormat.jm();
    final next = prayerTimes!.nextPrayer(date: DateTime.now());

    Duration? remaining;
    remaining = prayerTimes!.timeForPrayer(next).difference(DateTime.now());

    String remainingText = '';
    remainingText =
        'بعد ${remaining.inHours} ساعة و ${remaining.inMinutes % 60} دقيقة';

    return [
      PrayerTimeRow(
        prayerName: 'الفجر',
        time: format.format(prayerTimes!.fajr.toLocal()),
        icon: Icons.wb_twilight,
        prayerType: PrayerType.fajr,
        isActive: next == Prayer.fajr,
        remainingTime: next == Prayer.fajr ? remainingText : null,
        isNotificationEnabled: notificationStates[PrayerType.fajr] ?? true,
        onNotificationToggle: () => _toggleNotification(PrayerType.fajr),
      ),
      PrayerTimeRow(
        prayerName: 'الشروق',
        time: format.format(prayerTimes!.sunrise.toLocal()),
        icon: Icons.wb_sunny,
        prayerType: PrayerType.fajr, // Use fajr for sunrise notifications
        isActive: next == Prayer.sunrise,
        remainingTime: next == Prayer.sunrise ? remainingText : null,
        isNotificationEnabled: false, // No notifications for sunrise
      ),
      PrayerTimeRow(
        prayerName: 'الظهر',
        time: format.format(prayerTimes!.dhuhr.toLocal()),
        icon: Icons.wb_sunny_outlined,
        prayerType: PrayerType.dhuhr,
        isActive: next == Prayer.dhuhr,
        remainingTime: next == Prayer.dhuhr ? remainingText : null,
        isNotificationEnabled: notificationStates[PrayerType.dhuhr] ?? true,
        onNotificationToggle: () => _toggleNotification(PrayerType.dhuhr),
      ),
      PrayerTimeRow(
        prayerName: 'العصر',
        time: format.format(prayerTimes!.asr.toLocal()),
        icon: Icons.wb_cloudy,
        prayerType: PrayerType.asr,
        isActive: next == Prayer.asr,
        remainingTime: next == Prayer.asr ? remainingText : null,
        isNotificationEnabled: notificationStates[PrayerType.asr] ?? true,
        onNotificationToggle: () => _toggleNotification(PrayerType.asr),
      ),
      PrayerTimeRow(
        prayerName: 'المغرب',
        time: format.format(prayerTimes!.maghrib.toLocal()),
        icon: Icons.brightness_3,
        prayerType: PrayerType.maghrib,
        isActive: next == Prayer.maghrib,
        remainingTime: next == Prayer.maghrib ? remainingText : null,
        isNotificationEnabled: notificationStates[PrayerType.maghrib] ?? true,
        onNotificationToggle: () => _toggleNotification(PrayerType.maghrib),
      ),
      PrayerTimeRow(
        prayerName: 'العشاء',
        time: format.format(prayerTimes!.isha.toLocal()),
        icon: Icons.nightlight,
        prayerType: PrayerType.isha,
        isActive: next == Prayer.isha,
        remainingTime: next == Prayer.isha ? remainingText : null,
        isNotificationEnabled: notificationStates[PrayerType.isha] ?? true,
        onNotificationToggle: () => _toggleNotification(PrayerType.isha),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String dayName = DateFormat('EEEE', 'ar').format(now);
    final String meladiDate = DateFormat('d MMMM y', 'ar').format(now);
    HijriCalendar.setLocal('ar');
    final HijriCalendar hijri = HijriCalendar.now();
    final String hijriDate =
        '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear}';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 360.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                  image: DecorationImage(
                    image: AssetImage(AppImages.serviceCard),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 26.h,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'مواقيت الصلاة',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Cairo',
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'اوقات دقيقة حسب موقعك',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Cairo',
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CityCard(
                          cityName: cityName,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimary.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DateCard(
                          dayName: dayName,
                          meladiDate: meladiDate,
                          hijriDate: hijriDate,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: prayerTimes == null
                ? Center(
                    child: SpinKitFadingCircle(
                      color: isDark
                          ? Colors.white
                          : DarkAppColors.buttonBackground,
                    ),
                  )
                : ListView(
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    children: buildPrayerList(),
                  ),
          ),
        ],
      ),
    );
  }
}
