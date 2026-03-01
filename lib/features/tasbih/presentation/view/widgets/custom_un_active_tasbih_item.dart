import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';

class CustomUnActiveTasbihItem extends StatelessWidget {
  const CustomUnActiveTasbihItem({required this.tasbihName, super.key});
  final String tasbihName;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: ShapeDecoration(
        color: isDark
            ? const Color.fromRGBO(22, 32, 29, 1)
            : LightAppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 1.2,
            color: isDark
                ? const Color.fromRGBO(255, 255, 255, 0.04)
                : const Color.fromRGBO(0, 0, 0, 0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              tasbihName,
              textAlign: TextAlign.center,
              style: AppStyles.textRegular18(context),
            ),
          ),
        ),
      ),
    );
  }
}
