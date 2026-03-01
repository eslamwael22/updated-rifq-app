import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/reciters/data/models/reciters_model.dart';

class ReciterCard extends StatelessWidget {
  const ReciterCard({
    required this.reciter,
    required this.isDark,
    super.key,
  });

  final RecitersModel reciter;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark
        ? const Color(0xFF162A25)
        : const Color(0xFFE6F4EF);

    final borderColor = isDark
        ? const Color(0xFF2A4B3F)
        : const Color(0xFFBDE3D3);

    final iconColor = isDark
        ? const Color(0xFF2BD498)
        : const Color(0xFF0DA77B);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reciter.name,
                  style: AppStyles.textBold17(context).copyWith(),
                ),
                const SizedBox(height: 6),
                Text(
                  reciter.riwaya,
                  style: AppStyles.textRegular16(context).copyWith(
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.graphic_eq_rounded,
              size: 22,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
