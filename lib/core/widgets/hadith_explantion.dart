import 'package:flutter/material.dart';

class HadithExplanationWidget extends StatelessWidget {
  const HadithExplanationWidget({
    required this.explanation,
    required this.isDark,
    super.key,
  });

  final String explanation;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark
            ? Colors.white.withOpacity(.05)
            : const Color(0xFF0D7E5E).withOpacity(.06),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(.08)
              : const Color(0xFF0D7E5E).withOpacity(.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'شرح الحديث',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D7E5E),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            explanation,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.8,
              fontSize: 15,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
