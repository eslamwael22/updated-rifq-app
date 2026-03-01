import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/azkar/data/azkar.dart';
import 'package:sakina_app/features/azkar/data/models/category_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/category_gird_view.dart';

class AzkarViewBody extends StatelessWidget {
  const AzkarViewBody({super.key});

  List<CategoryModel> _buildCategories(bool isDark) {
    return [
      CategoryModel(
        colors: isDark
            ? [Color(0xFFB96A2C), Color(0xFF8F4E3F)]
            : [Color(0xffFFB347), Color(0xffFF7E5F)],
        imogi: '🌅',
        title: 'اذكار الصباح والمساء',
        zekrList: AzkarData.morningEveningAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF4B3FA3), Color(0xFF5E57B8)]
            : [Color(0xff6A5ACD), Color(0xff836FFF)],
        imogi: '📢',
        title: 'اذكار الاذان',
        zekrList: AzkarData.adhanAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF176B9E), Color(0xFF1487A0)]
            : [Color(0xff1FA2FF), Color(0xff12D8FA)],
        imogi: '🕋',
        title: 'أذكار بعد الصلاة',
        zekrList: AzkarData.afterPrayerAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF101820), Color(0xFF1A2A3A)]
            : [Color(0xff141E30), Color(0xff243B55)],
        imogi: '🌙',
        title: 'اذكار النوم',
        zekrList: AzkarData.sleepAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF0F6E66), Color(0xFF1E9B63)]
            : [Color(0xff11998E), Color(0xff38EF7D)],
        imogi: '🏠',
        title: 'أذكار المنزل',
        zekrList: AzkarData.homeAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF0F3F4A), Color(0xFF3E7D5E)]
            : [Color(0xff134E5E), Color(0xff71B280)],
        imogi: '🕌',
        title: 'أذكار المسجد',
        zekrList: AzkarData.mosqueAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF2D7CA0), Color(0xFF255FA8)]
            : [Color(0xff56CCF2), Color(0xff2F80ED)],
        imogi: '🚿',
        title: 'أذكار الوضوء',
        zekrList: AzkarData.wuduAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF2B3A3A), Color(0xFF8C7A5A)]
            : [Color(0xff3E5151), Color(0xffDECBA4)],
        imogi: '🚪',
        title: 'أذكار دخول الحمام',
        zekrList: AzkarData.bathroomAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF7A2A45), Color(0xFF151C4A)]
            : [Color(0xffC33764), Color(0xff1D2671)],
        imogi: '🤲',
        title: 'دعاء الاستخاره',
        zekrList: AzkarData.istikharaAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFFA86514), Color(0xFFB89B16)]
            : [Color(0xffF7971E), Color(0xffFFD200)],
        imogi: '👕',
        title: 'دعاء الملبس',
        zekrList: AzkarData.clothesAzkar,
      ),

      CategoryModel(
        colors: isDark
            ? [Color(0xFF5C1BA8), Color(0xFF3A0A9E)]
            : [Color(0xff8E2DE2), Color(0xff4A00E0)],
        imogi: '🧎‍♂️',
        title: 'ادعيه الصلاه',
        zekrList: AzkarData.prayerInsideAzkar,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        CustomAppBar(
          isShow: false,
          subTitle: 'حصن المسلم اليومي',
          title: 'الادعية و الأذكار',
        ),

        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                sliver: CategoryListView(
                  items: _buildCategories(isDark),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
