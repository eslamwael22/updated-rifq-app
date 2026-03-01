import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/names_of_allah/data/models/god_names_category_model.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/widgets/god_names_grid_view.dart';

class GodNamesCategoryBody extends StatelessWidget {
  const GodNamesCategoryBody({super.key});
  List<GodNamesCategoryModel> godNamesCategories(bool isDark) {
    return [
      GodNamesCategoryModel(
        id: 'all',
        title: 'أسماء الله الحسنى',
        assetPath: 'assets/json/all_names.json',
        icon: Icons.auto_awesome,
        colors: isDark
            ? [Color(0xFFB96A2C), Color(0xFF8F4E3F)]
            : [Color(0xffFFB347), Color(0xffFF7E5F)],
      ),

      GodNamesCategoryModel(
        id: 'quran',
        title: 'الأسماء المذكورة في القرآن',
        assetPath: 'assets/json/names_in_quran.json',
        icon: Icons.menu_book,
        colors: isDark
            ? [Color(0xFF4B3FA3), Color(0xFF5E57B8)]
            : [Color(0xff6A5ACD), Color(0xff836FFF)],
      ),

      GodNamesCategoryModel(
        id: 'pairs',
        title: 'الأسماء المتقابلة',
        assetPath: 'assets/json/pairs.json',
        icon: Icons.compare_arrows,
        colors: isDark
            ? [Color(0xFF176B9E), Color(0xFF1487A0)]
            : [Color(0xff1FA2FF), Color(0xff12D8FA)],
      ),

      GodNamesCategoryModel(
        id: 'not_in_quran',
        title: 'غير المذكورة في القرآن',
        assetPath: 'assets/json/not_in_quran.json',
        icon: Icons.list_alt,
        colors: isDark
            ? [Color(0xFF101820), Color(0xFF1A2A3A)]
            : [Color(0xff141E30), Color(0xff243B55)],
      ),

      GodNamesCategoryModel(
        id: 'greatest_name',
        title: 'اسم الله الأعظم',
        assetPath: 'assets/json/greatest_name.json',
        icon: Icons.star,
        colors: isDark
            ? [Color(0xFF0F6E66), Color(0xFF1E9B63)]
            : [Color(0xff11998E), Color(0xff38EF7D)],
      ),

      GodNamesCategoryModel(
        id: 'duaa',
        title: 'الأدعية المرتبطة بالأسماء',
        assetPath: 'assets/json/duaa.json',
        icon: Icons.volunteer_activism,
        colors: isDark
            ? [Color(0xFF0F3F4A), Color(0xFF3E7D5E)]
            : [Color(0xff134E5E), Color(0xff71B280)],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = godNamesCategories(isDark);
    return Column(
      children: [
        CustomAppBar(
          title: 'أسماء الله الحسنى',
          isShow: false,
          subTitle: 'تعرف على أسماء الله وصفاته',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GodNamesGridView(categories: categories),
          ),
        ),
      ],
    );
  }
}
