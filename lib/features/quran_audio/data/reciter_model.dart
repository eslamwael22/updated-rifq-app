class ReciterModel {
  final String reciterName;
  final String reciterUrl;
  final String fileName;
  Function(double) onProgress;

  ReciterModel({
    required this.reciterName,
    required this.reciterUrl,
    required this.fileName,
    required this.onProgress,
  });
}
