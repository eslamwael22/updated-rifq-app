import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/features/azkar/data/models/zekr_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/zekr_item_bottom.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/zekr_item_header.dart';

class ZekrItem extends StatelessWidget {
  const ZekrItem({required this.zekrModel, super.key});
  final ZekrModel zekrModel;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(10),
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
          ZekrItemHeader(
            count: zekrModel.count,
            zekr: zekrModel.zekr,
          ),
          SizedBox(height: 8.h),
          ZekrItemBottom(
            type1: zekrModel.type1,
            type2: zekrModel.type2,
          ),
        ],
      ),
    );
  }
}
