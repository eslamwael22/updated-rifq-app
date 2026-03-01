import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakina_app/core/service/reciter_download_service.dart';
import 'package:sakina_app/core/service/connection_service.dart';
import 'package:sakina_app/features/quran_audio/data/download_task.dart';
import 'package:sakina_app/features/quran_audio/data/reciter_model.dart';
import 'package:sakina_app/features/quran_audio/data/surah_model.dart';
import 'package:sakina_app/features/quran_audio/presentation/manager/audio_cubit.dart';
import 'package:sakina_app/features/reciters/data/models/reciters_model.dart';

part 'reciter_downloading_state.dart';

class ReciterDownloadingCubit extends Cubit<ReciterDownloadingState> {
  final ReciterDownloadService service;
  late AudioCubit audioCubit;
  final Map<String, DownloadTask> tasks = {};
  RecitersModel? selectedReciterModel;
  ReciterDownloadingCubit(
    this.service,
  ) : super(ReciterDownloadingInitial());
  void setAudioCubit(AudioCubit cubit) {
    audioCubit = cubit;
  }

  Future<void> initReciter(RecitersModel recitersModel) async {
    tasks.clear();
    selectedReciterModel = recitersModel;

    await _loadDownloadedSurahs(reciterName: recitersModel.name);
    await audioCubit.initPlaylist(recitersModel.name);
  }

  Future<void> _loadDownloadedSurahs({required String reciterName}) async {
    final dir = await getApplicationDocumentsDirectory();
    final recitersDir = Directory('${dir.path}/reciters/$reciterName');

    // تأكد من أن مجلد الـ reciter موجود
    if (!await recitersDir.exists()) {
      await recitersDir.create(recursive: true);
    }

    // اقرأ جميع ملفات mp3 في المجلد
    final files = await recitersDir.list().toList();
    for (final file in files) {
      if (file is File && file.path.endsWith('.mp3')) {
        final fileName = file.uri.pathSegments.last.replaceAll('.mp3', '');
        tasks[fileName] = DownloadTask(
          fileName: fileName,
          isLoaded: true,
          progress: 1.0,
        );
      }
    }

    // تأكد من إضافة أي سور تاني موجود في القائمة ولكنه محمل بالفعل
    for (var surah in SurahModel.surahList) {
      if (!tasks.containsKey(surah.fileName)) {
        final file = File('${recitersDir.path}/${surah.fileName}.mp3');
        if (await file.exists()) {
          tasks[surah.fileName] = DownloadTask(
            fileName: surah.fileName,
            isLoaded: true,
            progress: 1.0,
          );
        }
      }
    }

    emit(ReciterDownloadingUpdated(tasks.values.toList()));
  }

  Future<void> downloadReciter({required ReciterModel reciterModel}) async {
    final fileName = reciterModel.fileName;
    final reciterName = reciterModel.reciterName;
    final hasConnection = await ConnectionService.hasFullConnection();
    if (!hasConnection) {
      emit(ReciterFailure(errorMessage: 'لا يوجد اتصال بالإنترنت'));
      return;
    }

    if (!tasks.containsKey(fileName)) {
      final cancelToken = CancelToken();
      tasks[fileName] = DownloadTask(
        fileName: fileName,
        isDownloading: true,
        cancelToken: cancelToken,
      );
      emit(ReciterDownloadingUpdated(tasks.values.toList()));
    }

    reciterModel.onProgress = (progress) {
      final oldTask = tasks[fileName]!;
      tasks[fileName] = oldTask.copyWith(
        progress: progress,
        isDownloading: true,
      );
      emit(ReciterDownloadingUpdated(tasks.values.toList()));
    };

    final isDownloadedResult = await service.isSurahDownload(
      reciterName: reciterName,
      fileName: fileName,
    );

    bool isDownloaded = false;
    isDownloadedResult.fold(
      (failure) => emit(ReciterFailure(errorMessage: failure.errorMessage)),
      (exists) => isDownloaded = exists,
    );

    if (isDownloaded) {
      final oldTask = tasks[fileName]!;
      tasks[fileName] = oldTask.copyWith(
        isDownloading: false,
        isLoaded: true,
        progress: 1.0,
      );
      emit(ReciterDownloadingUpdated(tasks.values.toList()));
      return;
    }

    final cancelToken = tasks[fileName]!.cancelToken!;
    final result = await service.downloadSurah(
      reciterModel: reciterModel,
      cancelToken: cancelToken,
    );
    result.fold(
      (failure) => emit(ReciterFailure(errorMessage: failure.errorMessage)),
      (_) {
        final oldTask = tasks[fileName]!;
        tasks[fileName] = oldTask.copyWith(
          isDownloading: false,
          isLoaded: true,
          progress: 1.0,
        );
        emit(ReciterDownloadingUpdated(tasks.values.toList()));
      },
    );
  }

  bool isSurahDownloaded(String fileName) => tasks[fileName]?.isLoaded ?? false;
  void cancelDownload(String fileName) {
    final task = tasks[fileName];

    if (task != null && task.isDownloading) {
      task.cancelToken?.cancel();

      tasks.remove(fileName);

      emit(ReciterDownloadingUpdated(tasks.values.toList()));
    }
  }

  bool isSurahDownloading(String fileName) =>
      tasks[fileName]?.isDownloading ?? false;

  double getProgress(String fileName) => tasks[fileName]?.progress ?? 0.0;
}
