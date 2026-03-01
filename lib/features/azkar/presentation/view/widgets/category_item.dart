import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/features/azkar/data/models/category_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/azkar_details_view.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({required this.categoryModel, super.key});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AzkarDetailsView(zekr: categoryModel.zekrList),
          ),
        );
      },
      child: Container(
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
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // Icon/Emoji Container
            Center(
              child: Text(
                categoryModel.imogi,
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
            ),

            SizedBox(width: 22.w),

            // Title and Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    categoryModel.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${categoryModel.subTitle} ذكر',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16.h,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}
