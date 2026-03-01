import 'package:intl/date_symbol_data_local.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/azkar_keys.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/notification/notification_bootstrap.dart';
import 'package:sakina_app/core/notification/notification_init.dart';
import 'package:sakina_app/core/service/get_it_setup.dart';
import 'package:sakina_app/core/widgets/app_error_view.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/rifq_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  await getItSetup();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  await NotificationBootstrap.initTimeZone();
  SharedPref.init();
  await InitNotificationService.initNotification();
  await NotificationBootstrap.init();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const AppErrorView();
  };
  InitNotificationService.notificationStreamController.stream.listen((
    response,
  ) {
    final payload = response.payload;
    if (payload != null) {
      if (payload == AzkarKeys.eveningMorningAzkar) {
        InitNotificationService.navigatorKey.currentState?.pushNamed(
          AppRoutes.azkarView,
        );
      } else if (payload == AzkarKeys.tasbihAzkar) {
        InitNotificationService.navigatorKey.currentState?.pushNamed(
          AppRoutes.tasbihView,
        );
      } else if (payload == AzkarKeys.quranAzkar) {
        InitNotificationService.navigatorKey.currentState?.pushNamed(
          AppRoutes.quranWerd,
        );
      }
    }
  });

  if (kReleaseMode) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<ThemeCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<AudioCubit>(),
          ),
          BlocProvider(create: (_) => getIt.get<ReciterDownloadingCubit>()),
        ],
        child: const RifqApp(),
      ),
    );
  } else {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<ThemeCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<AudioCubit>(),
          ),
          BlocProvider(create: (_) => getIt.get<ReciterDownloadingCubit>()),
        ],
        child: DevicePreview(builder: (context) => const RifqApp()),
      ),
    );
  }
}
