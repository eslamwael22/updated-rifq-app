import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';

class RiquatActions extends StatelessWidget {
  const RiquatActions({required this.hadith, required this.isDark, super.key});
  final bool isDark;
  final String hadith;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            try {
              await FlutterClipboard.copy(hadith);
              showCustomSnackBar(
                context,
                'Copied to clipboard',
              );
            } on ClipboardException catch (e) {
              showCustomSnackBar(
                context,
                'Copy failed: ${e.message}',
                isError: true,
              );
            }
          },
          icon: Icon(
            Icons.copy,
            color: isDark ? Colors.white : const Color(0xFF0D7E5E),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: isDark ? Colors.white : const Color(0xFF0D7E5E),
          ),
        ),
      ],
    );
  }
}
