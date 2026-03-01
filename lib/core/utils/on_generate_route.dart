import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/features/azkar/presentation/view/azkar_view.dart';
import 'package:sakina_app/features/hadith/presentation/view/hadith_view.dart';
import 'package:sakina_app/features/home/presentation/views/home_page_view_body.dart';
import 'package:sakina_app/features/location_permission/presentation/views/location_permission.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/god_names_category_view.dart';
import 'package:sakina_app/features/notification_view/presentation/view/notification_view.dart';
import 'package:sakina_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:sakina_app/features/duas/presentation/views/duas_view.dart';
import 'package:sakina_app/features/quran/presentation/views/quran_view.dart';
import 'package:sakina_app/features/quran_audio/presentation/view/quran_audio_view.dart';
import 'package:sakina_app/features/reciters/presentation/view/reciters_view.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/riquat_shareia_view.dart';
import 'package:sakina_app/features/settings/presentation/view/settings_view.dart';
import 'package:sakina_app/features/splash/presentation/view/splash_view.dart';
import 'package:sakina_app/features/tasbih/presentation/view/tasbih_view.dart';

Route<dynamic> onGenerateRoute(
  RouteSettings settings,
) {
  switch (settings.name) {
    case AppRoutes.splashView:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case AppRoutes.onBoardingView:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case AppRoutes.quranAudioView:
      return MaterialPageRoute(
        builder: (_) => const AudioQuranView(),
      );
    case AppRoutes.locationPermissionView:
      return MaterialPageRoute(builder: (_) => const LocationPermissionView());
    case AppRoutes.tasbihView:
      return MaterialPageRoute(builder: (_) => const TasbihView());

    case AppRoutes.settingsView:
      return MaterialPageRoute(builder: (_) => const SettingsView());
    case AppRoutes.riquatShareiaView:
      return MaterialPageRoute(builder: (_) => const RiquatView());
    case AppRoutes.hadithView:
      return MaterialPageRoute(builder: (_) => const HadithView());
    case AppRoutes.recitersView:
      return MaterialPageRoute(
        builder: (_) => const RecitersView(),
      );
    case AppRoutes.notificationView:
      return MaterialPageRoute(builder: (_) => const NotificationView());
    case AppRoutes.duasView:
      return MaterialPageRoute(builder: (_) => const DuasView());
    case AppRoutes.homeView:
      return MaterialPageRoute(builder: (_) => const HomeViewBody());
    case AppRoutes.godNamesCategoryView:
      return MaterialPageRoute(builder: (_) => const GodNamesCategoryView());
    case AppRoutes.azkarView:
      return MaterialPageRoute(builder: (_) => const AzkarView());
    case AppRoutes.quranWerd:
      return MaterialPageRoute(builder: (_) => const QuranView());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
