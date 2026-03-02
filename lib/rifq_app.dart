import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/theme/dark_theme.dart';
import 'package:sakina_app/core/constants/theme/light_theme.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/notification/notification_init.dart';
import 'package:sakina_app/core/utils/on_generate_route.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class RifqApp extends StatelessWidget {
  const RifqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeState) {
            return MaterialApp(
              navigatorKey: InitNotificationService.navigatorKey,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('ar'),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: onGenerateRoute,
              title: 'Rifq App',
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: themeState,
              initialRoute: AppRoutes.splashView,
            );
          },
        );
      },
    );
  }
}
