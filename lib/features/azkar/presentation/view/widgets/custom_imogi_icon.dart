import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class customImogiIcon extends StatelessWidget {
  const customImogiIcon({required this.imogi, super.key});
  final String imogi;
  @override
  Widget build(BuildContext context) {
    return Text(
      imogi,
      style: AppStyles.textRegular20(context),
    );
  }
}