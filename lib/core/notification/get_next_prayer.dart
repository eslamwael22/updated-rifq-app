import 'package:geocoding/geocoding.dart';
import 'package:sakina_app/core/notification/prayer_model.dart';
import 'package:intl/intl.dart';
import 'package:sakina_app/features/prayer_times/data/prayer_time_service.dart';
import 'package:adhan_dart/adhan_dart.dart';

PrayerNoteModel getNextPrayer(List<PrayerNoteModel> prayers) {
  if (prayers.isEmpty) {
    return PrayerNoteModel(
      name: 'يتم اعادة جدولة المواعيد',
      dateTime: DateTime.now(),
    );
  }

  final now = DateTime.now();
  final upcoming = prayers.where((p) => p.dateTime.isAfter(now)).toList();

  if (upcoming.isNotEmpty) {
    return upcoming.reduce((a, b) => a.dateTime.isBefore(b.dateTime) ? a : b);
  } else {
    final first = prayers.first;
    return PrayerNoteModel(
      name: first.name,
      dateTime: first.dateTime.add(const Duration(days: 1)),
    );
  }
}

Future<String> getNextPrayerText(List<PrayerNoteModel>? prayers) async {
  final service = PrayerTimeService();
  final prayerTimes = await service.getPrayerTimes();
  
  if (prayerTimes == null) {
    return 'جاري تحميل مواقيت الصلاة...';
  }
  
  final now = DateTime.now();
  final nextPrayer = prayerTimes.nextPrayer(date: now);
  final nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
  
  if (nextPrayerTime == null) {
    return 'لا يمكن تحديد مواقيت الصلاة';
  }
  
  // Use the same logic as UI - convert to local time
  final localPrayerTime = nextPrayerTime.toLocal();
  final remaining = localPrayerTime.difference(now);
  
  // Combine day and date in one line
  final dayName = DateFormat('EEEE', 'ar').format(now);
  final gregorianDate = DateFormat('d MMMM yyyy', 'ar').format(now);
  final fullDate = '$dayName, $gregorianDate';
  
  // Use same format as UI - DateFormat.jm() without locale
  final format = DateFormat.jm();
  final prayerTime = format.format(localPrayerTime);
  
  // Get prayer name in Arabic
  final prayerName = _getPrayerNameArabic(nextPrayer);
  
  String remainingText;
  if (remaining.isNegative) {
    remainingText = 'الآن';
  } else {
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;
    
    if (hours > 0) {
      remainingText = 'متبقي $hours ساعة و $minutes دقيقة';
    } else if (minutes > 0) {
      remainingText = 'متبقي $minutes دقيقة';
    } else {
      remainingText = 'متبقي $seconds ثانية';
    }
  }
  
  // Get location from saved city name
  String location = 'جاري تحديد الموقع...';
  try {
    location = await service.getCityName();
  } catch (e) {
    location = 'غير محدد';
  }
  
  return '$fullDate  -  $location\n$prayerName  $prayerTime   ....   $remainingText';
}

String _getPrayerNameArabic(Prayer prayer) {
  switch (prayer) {
    case Prayer.fajr:
      return 'صلاة الفجر';
    case Prayer.fajrAfter:
      return 'صلاة الفجر';
    case Prayer.sunrise:
      return 'الشروق';
    case Prayer.dhuhr:
      return 'صلاة الظهر';
    case Prayer.asr:
      return 'صلاة العصر';
    case Prayer.maghrib:
      return 'صلاة المغرب';
    case Prayer.isha:
      return 'صلاة العشاء';
    case Prayer.ishaBefore:
      return 'صلاة العشاء';
  }
}
