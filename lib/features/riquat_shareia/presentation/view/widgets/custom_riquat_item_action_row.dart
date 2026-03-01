import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sakina_app/core/utils/custom_snack_bar.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/custom_riquat_item_action.dart';

class CustomRiquatItemActionRow extends StatelessWidget {
  const CustomRiquatItemActionRow({
    required this.riquat,
    required this.isDark,
    super.key,
  });

  final bool isDark;
  final String riquat;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomRiquatItemAction(
          icon: Icons.copy,
          isDark: isDark,
          onPressed: () async {
            try {
              await FlutterClipboard.copy(riquat);
              showCustomSnackBar(
                context,
                'تمت عملية النسخ بنجاح',
              );
            } on ClipboardException catch (e) {
              showCustomSnackBar(
                context,
                'Copy failed: ${e.message}',
                isError: true,
              );
            }
          },
        ),
      ],
    );
  }
}
