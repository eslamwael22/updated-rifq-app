// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get splashViewTitle => 'المصحف الشريف';

  @override
  String get splashViewSubTitle => '﴿ وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا ﴾';

  @override
  String get splashViewDesc => 'سورة المزمل - آية 4';

  @override
  String get firstOnBoardingTitle => 'القرآن الكريم';

  @override
  String get firstOnBoardingSubTitle => 'اقرأ القرآن الكريم بخط واضح وتصميم جميل مع إمكانية الاستماع للتلاوات';

  @override
  String get secondOnBoardingTitle => 'مواقيت الصلاة';

  @override
  String get secondOnBoardingSubTitle => 'تنبيهات دقيقة لمواقيت الصلاة حسب موقعك مع صوت الأذان';

  @override
  String get thirdOnBoardingTitle => 'رفيقك الروحاني';

  @override
  String get thirdOnBoardingSubTitle => 'تذكيرات يومية، أذكار، تسبيح، وكل ما تحتاجه في رحلتك الإيمانية';

  @override
  String get skipText => 'تخطي';

  @override
  String get onBoardingButtonbuttonText => 'متابعة';

  @override
  String get languageSelectionTitle => 'اختر اللغة';

  @override
  String get firstLanguage => 'العربية';

  @override
  String get secondLanguage => 'الانجليزية';

  @override
  String get thirdLanguage => 'اردو';

  @override
  String get fourthLanguage => 'فرنسية';

  @override
  String get identifyLocationTitle => 'تحديد الموقع';

  @override
  String get identifyLocationSubTitle => 'نحتاج إلى موقعك لحساب أوقات الصلاة الدقيقة في منطقتك وإظهار المساجد القريبة منك';

  @override
  String get firstLocationListTile => 'تحديد اتجاه القبلة';

  @override
  String get firstLocationListTileSubTitle => 'نستخدم موقعك لتحديد اتجاه الكعبة بدقة أينما كنت';

  @override
  String get secondLocationListTile => 'تحديد موقعك';

  @override
  String get secondLocationListTileSubTitle => 'نحتاج إلى موقعك لتحسين تجربة الاستخدام داخل التطبيق';

  @override
  String get thirdLocationListTile => 'خصوصيتك أولاً';

  @override
  String get thirdLocationListTileSubTitle => 'لا يتم تخزين أو مشاركة بيانات موقعك مع أي جهة';

  @override
  String get selectionLocationButtonText => 'السماح بصلاحيات الموقع';

  @override
  String get selectionLocationSetting => 'يمكنك تغيير هذا الإعداد لاحقًا من الإعدادات';

  @override
  String get locationServicesDisabled => 'خدمات الموقع معطلة.';

  @override
  String get locationPermissionsDenied => 'صلاحيات الموقع مرفوضة.';

  @override
  String get locationPermissionsDeniedForever => 'صلاحيات الموقع مرفوضة بشكل دائم، لا يمكن طلبها.';

  @override
  String get failedToGetCurrentLocation => 'فشل الحصول على الموقع الحالي.';
}
