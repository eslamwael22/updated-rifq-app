// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get splashViewTitle => 'Al-Mushaf Al-Sharif';

  @override
  String get splashViewSubTitle => 'Recite the Quran with tartil';

  @override
  String get splashViewDesc => 'Surah Al-Muzzammil - Verse 4';

  @override
  String get firstOnBoardingTitle => 'The Holy Quran';

  @override
  String get firstOnBoardingSubTitle => 'Read the Quran clearly with beautiful design and listen to recitations';

  @override
  String get secondOnBoardingTitle => 'Prayer Times';

  @override
  String get secondOnBoardingSubTitle => 'Accurate notifications for prayer times according to your location with Adhan sound';

  @override
  String get thirdOnBoardingTitle => 'Your Spiritual Companion';

  @override
  String get thirdOnBoardingSubTitle => 'Daily reminders, Azkar, Tasbeeh, everything you need in your spiritual journey';

  @override
  String get skipText => 'Skip';

  @override
  String get onBoardingButtonbuttonText => 'Continue';

  @override
  String get languageSelectionTitle => 'Choose Language';

  @override
  String get firstLanguage => 'Arabic';

  @override
  String get secondLanguage => 'English';

  @override
  String get thirdLanguage => 'Urdu';

  @override
  String get fourthLanguage => 'French';

  @override
  String get identifyLocationTitle => 'Location';

  @override
  String get identifyLocationSubTitle => 'We need your location to calculate accurate prayer times';

  @override
  String get firstLocationListTile => 'Find Qibla Direction';

  @override
  String get firstLocationListTileSubTitle => 'We use your location to accurately determine the direction of the Kaaba wherever you are';

  @override
  String get secondLocationListTile => 'Detect Your Location';

  @override
  String get secondLocationListTileSubTitle => 'Your location is required to improve your in-app experience';

  @override
  String get thirdLocationListTile => 'Your Privacy Matters';

  @override
  String get thirdLocationListTileSubTitle => 'Your location data is never stored or shared with anyone';

  @override
  String get selectionLocationButtonText => 'Allow location access';

  @override
  String get selectionLocationSetting => 'You can change this later in settings';

  @override
  String get locationServicesDisabled => 'Location services are disabled.';

  @override
  String get locationPermissionsDenied => 'Location permission denied.';

  @override
  String get locationPermissionsDeniedForever => 'Location permission denied permanently.';

  @override
  String get failedToGetCurrentLocation => 'Failed to get current location.';
}
