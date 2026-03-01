import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class DownloadTask extends Equatable {
  final String fileName;
  final double progress;
  final bool isDownloading;
  final bool isLoaded;
  final CancelToken? cancelToken;

  const DownloadTask({
    required this.fileName,
    this.progress = 0.0,
    this.isDownloading = false,
    this.isLoaded = false,
    this.cancelToken,
  });

  DownloadTask copyWith({
    double? progress,
    bool? isDownloading,
    bool? isLoaded,
    CancelToken? cancelToken,
  }) {
    return DownloadTask(
      fileName: fileName,
      progress: progress ?? this.progress,
      isDownloading: isDownloading ?? this.isDownloading,
      isLoaded: isLoaded ?? this.isLoaded,
      cancelToken: cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [
    fileName,
    progress,
    isDownloading,
    isLoaded,
    cancelToken,
  ];
}
