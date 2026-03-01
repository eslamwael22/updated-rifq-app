import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomSettingsIcon extends StatelessWidget {
  const CustomSettingsIcon({
    required this.icon,
    super.key,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(
          color: LightAppColors.greenColor0D7,
          shape: OvalBorder(),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
