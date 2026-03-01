import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/riquat_quran_model/riquat_quran_model.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/custom_riquat_item_action_row.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/custom_riquat_limit_num.dart';

class RiquatQuranItem extends StatelessWidget {
  const RiquatQuranItem({
    required this.isDark,
    required this.model,

    super.key,
  });
  final bool isDark;
  final RiquatQuranModel model;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'سورة ${model.surah}',
                style: AppStyles.textMedium20(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              CustomRiquatItemActionRow(
                isDark: isDark,
                riquat: model.text ?? '',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            model.text ?? '',
            style: AppStyles.textRegular18Amiri(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomRiquatLimitNum(
                  isDark: isDark,
                  model: model.endAyah.toString(),
                ),
                const SizedBox(width: 6),
                Text(
                  '-',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDark
                        ? DarkAppColors.primaryLight
                        : LightAppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 6),
                CustomRiquatLimitNum(
                  isDark: isDark,
                  model: model.startAyah.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
