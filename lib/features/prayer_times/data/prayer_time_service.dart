import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimeService {
  static const String latitudeKey = 'user_latitude';
  static const String longitudeKey = 'user_longitude';
  static const String lastUpdateKey = 'last_prayer_update';

  Future<PrayerTimes?> getPrayerTimes({bool forceUpdate = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getString(lastUpdateKey);
    final today = DateTime.now().toString().substring(0, 10);

    // لو آخر تحديث مش النهاردة أو محتاج تحديث قسري
    if (lastUpdate != today || forceUpdate) {
      final position = await determinePosition();

      if (position == null) {
        return null;
      }

      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationParameters(
        fajrAngle: 19.5,
        ishaAngle: 17.5,
        method: CalculationMethod.egyptian,
      );
      params.madhab = Madhab.shafi;

      final prayerTimes = PrayerTimes(
        coordinates: coordinates,
        date: DateTime.now().toLocal(),
        calculationParameters: params,
        precision: true,
      );

      // خزن تاريخ آخر تحديث
      await prefs.setString(lastUpdateKey, today);

      return prayerTimes;
    }

    // لو آخر تحديث كان النهاردة ومش محتاج تحديث قسري
    // استدعي الدالة تاني ب forceUpdate عشان نحسب المواقيت
    return calculatePrayerTimes();
  }

  Future<PrayerTimes?> calculatePrayerTimes() async {
    final position = await determinePosition();

    if (position == null) {
      return null;
    }

    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationParameters(
      fajrAngle: 19.5,
      ishaAngle: 17.5,
      method: CalculationMethod.egyptian,
    );
    params.madhab = Madhab.shafi;

    final prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: DateTime.now().toLocal(),
      calculationParameters: params,
      precision: true,
    );

    return prayerTimes;
  }

  Future<List<PrayerTimes>> getPrayerTimesForRange({int days = 30}) async {
    final position = await determinePosition();

    if (position == null) {
      return [];
    }

    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationParameters(
      fajrAngle: 19.5,
      ishaAngle: 17.5,
      method: CalculationMethod.egyptian,
    );
    params.madhab = Madhab.shafi;

    final now = DateTime.now();
    final List<PrayerTimes> result = [];

    for (int i = 0; i < days; i++) {
      final date = now.add(Duration(days: i));
      result.add(
        PrayerTimes(
          coordinates: coordinates,
          date: date.toLocal(),
          calculationParameters: params,
          precision: true,
        ),
      );
    }

    return result;
  }

  Future<Position?> determinePosition() async {
    // اولاً حاول نقرأ الموقع المخزن
    final cachedPosition = await getCachedPosition();
    if (cachedPosition != null) {
      return cachedPosition;
    }

    // لو مش موجود، اطلب الموقع
    final newPosition = await requestNewPosition();
    if (newPosition != null) {
      await cachePosition(newPosition);
    }

    return newPosition;
  }

  Future<Position?> getCachedPosition() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final latitude = prefs.getDouble(latitudeKey);
      final longitude = prefs.getDouble(longitudeKey);

      if (latitude != null && longitude != null) {
        return Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );
      }
    } catch (e) {
      print('Error reading cached position: $e');
    }
    return null;
  }

  Future<Position?> requestNewPosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> cachePosition(Position position) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(latitudeKey, position.latitude);
      await prefs.setDouble(longitudeKey, position.longitude);
    } catch (e) {
      print('Error caching position: $e');
    }
  }

  // method لمسح الموقع المخزن (لو احتجناه)
  Future<void> clearCachedPosition() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(latitudeKey);
      await prefs.remove(longitudeKey);
    } catch (e) {
      print('Error clearing cached position: $e');
    }
  }

  // method عشان نجيب اسم المدينة من الإحداثيات
  Future<String> getCityName() async {
    print('Getting city name...');
    final position = await determinePosition();

    if (position == null) {
      print('Position is null');
      return 'موقع غير محدد';
    }

    print('Position: ${position.latitude}, ${position.longitude}');

    // استخدام geocoding لجلب اسم المدينة
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      print('Found ${placemarks.length} placemarks');

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];
        final String city =
            place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea ??
            'مدينة غير معروفة';
        final String country = place.country ?? 'دولة غير معروفة';

        // تحويل اسم المدينة للعربي
        final String arabicCity = _translateCityToArabic(city);
        final String arabicCountry = _translateCountryToArabic(country);

        print('City: $arabicCity, Country: $arabicCountry');
        return '$arabicCity - $arabicCountry';
      }
    } catch (e) {
      print('Error getting city name: $e');
    }

    // لو فشل geocoding، رجع رسالة عامة
    return 'موقعك الحالي';
  }

  // تحويل اسم المدينة للعربي
  String _translateCityToArabic(String city) {
    final Map<String, String> cityMap = {
      'Cairo': 'القاهرة',
      'Alexandria': 'الإسكندرية',
      'Giza': 'الجيزة',
      'Shubra El Kheima': 'شبرا الخيمة',
      'Port Said': 'بورسعيد',
      'Suez': 'السويس',
      'Luxor': 'الأقصر',
      'Aswan': 'أسوان',
      'Asyut': 'أسيوط',
      'Tanta': 'طنطا',
      'Ismailia': 'الإسماعيلية',
      'Faiyum': 'الفيوم',
      'Zagazig': 'الزقازيق',
      'Mansoura': 'المنصورة',
      'El-Mahalla El-Kubra': 'المحلة الكبرى',
      'Damietta': 'دمياط',
      'Minya': 'المنيا',
      'Beni Suef': 'بني سويف',
      'Qena': 'قنا',
      'Sohag': 'سوهاج',
      'Hurghada': 'الغردقة',
      '6th of October City': 'السادس من أكتوبر',
      'Sharm El Sheikh': 'شرم الشيخ',
      'New Cairo': 'القاهرة الجديدة',
      'Marsa Matruh': 'مرسى مطروح',
      'Horin': 'هورين',
      'Birket elsabaa': 'بركه السبع',
    };

    return cityMap[city] ?? city;
  }

  // تحويل اسم الدولة للعربي
  String _translateCountryToArabic(String country) {
    final Map<String, String> countryMap = {
      'Egypt': 'مصر',
      'Saudi Arabia': 'السعودية',
      'United Arab Emirates': 'الإمارات',
      'Kuwait': 'الكويت',
      'Bahrain': 'البحرين',
      'Qatar': 'قطر',
      'Oman': 'عمان',
      'Yemen': 'اليمن',
      'Jordan': 'الأردن',
      'Syria': 'سوريا',
      'Lebanon': 'لبنان',
      'Iraq': 'العراق',
      'Palestine': 'فلسطين',
      'Sudan': 'السودان',
      'Libya': 'ليبيا',
      'Tunisia': 'تونس',
      'Algeria': 'الجزائر',
      'Morocco': 'المغرب',
      'Mauritania': 'موريتانيا',
    };

    return countryMap[country] ?? country;
  }
}
