class ReciterPlaybackState {
  final String filePath;
  final int index;
  final Duration position;
  final String reciterName;
  ReciterPlaybackState({
    required this.filePath,
    required this.index,
    required this.position,
    required this.reciterName,
  });
}
