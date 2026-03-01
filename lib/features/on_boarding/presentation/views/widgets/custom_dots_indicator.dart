import 'package:flutter/material.dart';
import 'package:sakina_app/features/on_boarding/data/models/on_boarding_model.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    required ValueNotifier<int> currentIndex,
    super.key,
  }) : _currentIndex = currentIndex;

  final ValueNotifier<int> _currentIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activeColor = isDark
        ? const Color(0xFF2BD498)
        : const Color(0xFF0DA77B);

    final inactiveColor = isDark ? Colors.white24 : Colors.black26;

    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            OnBoardingModel.onBoardingList.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: i == value ? 28 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == value ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}
