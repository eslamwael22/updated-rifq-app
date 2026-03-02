import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakina_app/core/constants/sentry_key.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/notification/notification_bootstrap.dart';
import 'package:sakina_app/core/notification/notification_init.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/core/widgets/app_error_view.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/rifq_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await SentryFlutter.init(
        (options) {
          options.dsn = SentryKey.sentryKey;
          options.environment = kReleaseMode ? 'production' : 'development';
          options.tracesSampleRate = 1.0;
          options.attachStacktrace = true;
        },
      );

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        Sentry.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        Sentry.captureException(error, stackTrace: stack);
        return true;
      };

      if (kReleaseMode) {
        ErrorWidget.builder = (details) => const AppErrorView();
      }

      try {
        await initializeDateFormatting('ar');
        await getItSetup();

        HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
        );

        await NotificationBootstrap.initTimeZone();
        await SharedPref.init();
        await InitNotificationService.initNotification();

        try {
          await NotificationBootstrap.init();
        } catch (e, s) {
          await Sentry.captureException(e, stackTrace: s);
        }
      } catch (e, s) {
        await Sentry.captureException(e, stackTrace: s);
        rethrow;
      }

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt.get<ThemeCubit>()),
            BlocProvider(create: (_) => getIt.get<AudioCubit>()),
            BlocProvider(create: (_) => getIt.get<ReciterDownloadingCubit>()),
          ],
          child: kReleaseMode
              ? const RifqApp()
              : DevicePreview(builder: (_) => const RifqApp()),
        ),
      );
      Future.microtask(() async {
        try {
          await InitNotificationService.requestPermission();
        } catch (e, s) {
          await Sentry.captureException(e, stackTrace: s);
        }
      });
    },
    (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
    },
  );
}
