import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/features/hadith/data/models/hadith_model/hadith_model.dart';

class CustomBottomSheetCopyIcon extends StatelessWidget {
  const CustomBottomSheetCopyIcon({
    required this.hadith,
    required this.isDark,
    super.key,
  });

  final HadithModel hadith;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        try {
          await FlutterClipboard.copy(hadith.explanation ?? '');
          Navigator.pop(context);
          showCustomSnackBar(
            context,
            'تم نسخ الحديث',
          );
        } on ClipboardException catch (e) {
          Navigator.pop(context);
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
    );
  }
}
