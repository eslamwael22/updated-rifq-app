import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sakina_app/core/error/failure.dart';
import 'package:sakina_app/core/error/server_failure.dart';
import 'package:sakina_app/features/quran_audio/data/reciter_model.dart';

class ReciterDownloadService {
  final Dio dio;

  ReciterDownloadService({required this.dio});
  Future<Either<Failure, String>> getLocalPath({
    required String reciterName,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final reciterDir = Directory('${dir.path}/reciters/$reciterName');
      if (!await reciterDir.exists()) {
        await reciterDir.create(recursive: true);
      }
      return Right(reciterDir.path);
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: e.toString()),
      );
    }
  }

  Future<Either<Failure, void>> downloadSurah({
    required ReciterModel reciterModel,
    required CancelToken cancelToken,
  }) async {
    try {
      final pathResult = await getLocalPath(
        reciterName: reciterModel.reciterName,
      );

      return await pathResult.fold(
        (failure) async => Left(failure),
        (dirPath) async {
          try {
            await dio.download(
              reciterModel.reciterUrl,
              '$dirPath/${reciterModel.fileName}.mp3',
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  reciterModel.onProgress(received / total);
                }
              },
              cancelToken: cancelToken,
            );
            return const Right(null);
          } catch (e) {
            return Left(
              ServerFailure(errorMessage: e.toString()),
            );
          }
        },
      );
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: e.toString()),
      );
    }
  }

  Future<Either<Failure, bool>> isSurahDownload({
    required String reciterName,
    required String fileName,
  }) async {
    try {
      final path = await getLocalPath(reciterName: reciterName);
      return await path.fold(
        (failure) async => Left(failure),
        (dirPath) async {
          final file = File('$dirPath/$fileName.mp3');
          return Right(await file.exists());
        },
      );
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: e.toString()),
      );
    }
  }
}
