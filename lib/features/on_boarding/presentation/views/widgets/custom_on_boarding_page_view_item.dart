import 'package:flutter/material.dart';
import 'package:sakina_app/features/on_boarding/data/models/on_boarding_model.dart';

class CustomOnBoardingItem extends StatelessWidget {
  const CustomOnBoardingItem({
    required this.page,
    super.key,
  });

  final OnBoardingModel page;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final iconColor = isDark
        ? const Color(0xFF2BD498)
        : const Color(0xFF0DA77B);

    final titleColor = isDark ? Colors.white : const Color(0xFF1A1A1A);

    final descColor = isDark ? Colors.white70 : const Color(0xFF6B6B6B);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.15),
          ),
          child: Icon(
            page.icon,
            size: 80,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          page.desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: descColor,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
