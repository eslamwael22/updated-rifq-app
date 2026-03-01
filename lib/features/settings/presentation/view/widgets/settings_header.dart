import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({required this.header, super.key});
  final String header;
  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      textAlign: TextAlign.right,
      style: AppStyles.textMedium12(context).copyWith(
        height: 1.33,
        letterSpacing: 0.30,
        fontSize: 14
      ),
    );
  }
}
