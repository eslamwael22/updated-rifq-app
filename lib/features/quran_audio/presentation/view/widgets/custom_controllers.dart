import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  final int index;
  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;

  const AudioControls({
    required this.index,
    required this.isPlaying,
    required this.onPrevious,
    required this.onPlayPause,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: index > 0 ? onPrevious : null,
          icon: const Icon(Icons.skip_previous),
          iconSize: 36,
          color: Colors.teal,
        ),
        const SizedBox(width: 24),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
          child: IconButton(
            onPressed: onPlayPause,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            iconSize: 36,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 24),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.skip_next),
          iconSize: 36,
          color: Colors.teal,
        ),
      ],
    );
  }
}
