import 'package:flutter/material.dart';
import '../../domain/models/qiblah_direction.dart';

class CornerWidget extends StatelessWidget {
  final QiblahDirection qiblah;
  const CornerWidget({required this.qiblah, super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.15),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'زاوية الجهاز: ${qiblah.direction.toStringAsFixed(2)}°',
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'زاوية القبلة: ${qiblah.qiblah.toStringAsFixed(2)}°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: scheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
