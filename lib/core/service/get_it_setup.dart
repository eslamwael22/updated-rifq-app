import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sakina_app/core/helper/audio_handler.dart';
import 'package:sakina_app/core/manager/theme_hydrated_cubit.dart';
import 'package:sakina_app/core/service/my_audio_service.dart';
import 'package:sakina_app/core/service/get_location_service.dart';
import 'package:sakina_app/core/service/reciter_download_service.dart';
import 'package:sakina_app/features/hadith/presentation/manager/cubit/hadith_cubit.dart';
import 'package:sakina_app/features/location_permission/presentation/manager/cubit/location_cubit.dart';
import 'package:sakina_app/features/notification_view/presentation/manager/notification_cubit.dart';
import 'package:sakina_app/features/duas/data/repo/dua_repo.dart';
import 'package:sakina_app/features/duas/data/repo/dua_repo_impl.dart';
import 'package:sakina_app/features/duas/presentation/manager/cubit/duas_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/reciter_download/reciter_downloading_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_quran_cubit/riquat_quran_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_sunnah_cubit/riquat_sunnah_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton(() => LocationService());
  getIt.registerFactory<LocationCubit>(
    () => LocationCubit(getIt.get<LocationService>()),
  );
  getIt.registerFactory<TasbihCubit>(() => TasbihCubit());
  getIt.registerLazySingleton<ReciterDownloadService>(
    () => ReciterDownloadService(dio: Dio()),
  );
  getIt.registerFactory(() => NotificationCubit());
  final myAudioService = MyAudioService.instance;

  final reciterCubit = ReciterDownloadingCubit(
    getIt.get<ReciterDownloadService>(),
  );
  getIt.registerSingleton<ReciterDownloadingCubit>(reciterCubit);

  final audioHandler = await AudioService.init(
    builder: () => AudioHandlerHelper(
      myAudioService.player,
      reciterCubit: reciterCubit,
    ),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.sakina.audio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );
  getIt.registerSingleton<AudioHandlerHelper>(audioHandler);

  final audioCubit = AudioCubit(audioHandler, reciterCubit);
  getIt.registerSingleton<AudioCubit>(audioCubit);

  reciterCubit.setAudioCubit(audioCubit);

  getIt.registerFactory(() => RiquatSunnahCubit());
  getIt.registerFactory(() => RiquatQuranCubit());
  getIt.registerFactory(() => HadithCubit());
  getIt.registerLazySingleton<DuaRepo>(
    () => DuaRepoImpl(),
  );
  getIt.registerFactory(
    () => DuasCubit(
      duaRepo: getIt.get<DuaRepo>(),
    ),
  );
}
