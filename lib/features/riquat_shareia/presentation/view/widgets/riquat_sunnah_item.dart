import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/riquat_model.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/custom_riquat_item_action_row.dart';

class RiquatSunnahItem extends StatelessWidget {
  const RiquatSunnahItem({
    required this.isDark,
    required this.model,

    super.key,
  });
  final bool isDark;
  final RiquatSunnahModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? DarkAppColors.container : LightAppColors.whiteColor,
        border: Border.all(
          color: isDark
              ? DarkAppColors.primaryLight
              : LightAppColors.primaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? DarkAppColors.glow : LightAppColors.blackColor19D,
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? DarkAppColors.primaryLight.withOpacity(0.2)
                  : LightAppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              model.number,
              style: AppStyles.textMedium20(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isDark ? Colors.white : LightAppColors.blackColor19D,
                shadows: [
                  Shadow(
                    color: isDark ? Colors.white24 : Colors.white,
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            model.text,
            style: AppStyles.textRegular18(context).copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          CustomRiquatItemActionRow(isDark: isDark, riquat: model.text),
        ],
      ),
    );
  }
}
