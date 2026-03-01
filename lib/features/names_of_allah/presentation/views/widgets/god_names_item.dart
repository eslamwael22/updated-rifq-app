import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/names_of_allah/data/models/god_names_category_model.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/god_names_detials_view.dart';

class GodNamesItem extends StatelessWidget {
  final GodNamesCategoryModel category;

  const GodNamesItem({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(23),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CategoryDetailsScreen(godNamesCategoryModel: category);
            },
          ),
        );
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Icon(
                category.icon,
                size: 24,
                color: isDark ? Colors.white : LightAppColors.primaryColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    category.title,

                    style: AppStyles.textMedium24(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
