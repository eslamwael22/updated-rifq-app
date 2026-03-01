import 'package:flutter/material.dart';

class CustomAudioSlider extends StatelessWidget {
  final double value;
  final double max;
  final ValueChanged<double> onChanged;
  final void Function(double)? onChangeEnd;
  final void Function(double)? onChangeStart;
  const CustomAudioSlider({
    required this.value,
    required this.max,
    required this.onChanged,
    super.key,
    this.onChangeEnd,
    this.onChangeStart,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      max: max,
      onChangeEnd: onChangeEnd,
      onChangeStart: onChangeStart,
      onChanged: onChanged,
      activeColor: Colors.teal,
      inactiveColor: Colors.teal.withOpacity(0.3),
    );
  }
}
