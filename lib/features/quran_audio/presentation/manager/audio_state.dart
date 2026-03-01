import 'package:equatable/equatable.dart';

class AudioState extends Equatable {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final int currentIndex;
  final String? currentTitle;
  final String? currentFilePath;
  final String? currentReciter;
  const AudioState({
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.currentIndex,
    this.currentFilePath,
    this.currentTitle,
    this.currentReciter,
  });

  factory AudioState.initial() {
    return const AudioState(
      isPlaying: false,
      position: Duration.zero,
      duration: Duration.zero,
      currentIndex: -1,
      currentTitle: '',
      currentReciter: '',
    );
  }

  AudioState copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    int? currentIndex,
    String? currentFilePath,
    String? currentTitle,
    String? currentReciter,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentIndex: currentIndex ?? this.currentIndex,
      currentFilePath: currentFilePath ?? this.currentFilePath,
      currentTitle: currentTitle ?? this.currentTitle,
      currentReciter: currentReciter ?? this.currentReciter,
    );
  }

  @override
  List<Object?> get props => [
    isPlaying,
    position,
    duration,
    currentIndex,
    currentFilePath,
    currentTitle,
  ];
}
