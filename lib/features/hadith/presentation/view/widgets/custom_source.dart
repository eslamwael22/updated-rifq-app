import 'package:flutter/material.dart';

class HadithSourceWidget extends StatelessWidget {
  const HadithSourceWidget({
    required this.source,
    required this.isDark,
    super.key,
  });

  final String source;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark
              ? Colors.white.withOpacity(.06)
              : const Color(0xFF0D7E5E).withOpacity(.08),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(.1)
                : const Color(0xFF0D7E5E).withOpacity(.25),
          ),
        ),
        child: Text(
          source,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
