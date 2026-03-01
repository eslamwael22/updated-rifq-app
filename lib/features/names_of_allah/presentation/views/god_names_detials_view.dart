import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/names_of_allah/data/models/god_names_category_model.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/widgets/god_item_card.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/widgets/god_not_specific_item.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final GodNamesCategoryModel godNamesCategoryModel;
  const CategoryDetailsScreen({
    required this.godNamesCategoryModel,
    super.key,
  });

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  dynamic data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString(
      widget.godNamesCategoryModel.assetPath,
    );
    final decoded = json.decode(response);

    setState(() {
      data = decoded;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF1C1C1A)
            : const Color(0xFFF8F7F4),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomAppBar(
                    isShow: false,
                    subTitle: 'تعرف على أسماء الله وصفاته',
                    title: widget.godNamesCategoryModel.title,
                  ),
                  Expanded(child: _buildContent()),
                ],
              ),
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.godNamesCategoryModel.id) {
      case 'all':
      case 'quran':
        return _buildNormalNames();

      case 'pairs':
        return _buildPairs();

      case 'not_in_quran':
        return _buildSimpleList();

      case 'greatest_name':
        return _buildGreatestName();

      case 'duaa':
        return _buildDuaa();

      default:
        return const Center(child: Text('لا يوجد محتوى'));
    }
  }

  // ------------------------------
  // 1️⃣ الأسماء العادية
  Widget _buildNormalNames() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GodItemCard(
            title: item['name'],
            subtitle: item['meaning'],
          ),
        );
      },
    );
  }

  // ------------------------------
  // 2️⃣ الأسماء المتقابلة
  Widget _buildPairs() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GodItemCard(
            title: item['pair'],
            subtitle: item['meaning'],
          ),
        );
      },
    );
  }

  // ------------------------------
  // 3️⃣ غير المذكورة في القرآن
  Widget _buildSimpleList() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),

      itemCount: data['names'].length,
      itemBuilder: (context, index) {
        final name = data['names'][index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: GodNotItemCard(
            title: name,
          ),
        );
      },
    );
  }

  // ------------------------------
  // 4️⃣ اسم الله الأعظم
  Widget _buildGreatestName() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...data['references'].map<Widget>((ref) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GodItemCard(
              title: ref['hadith_source'],
              subtitle: ref['text'],
            ),
          );
        }).toList(),
      ],
    );
  }

  // ------------------------------
  // 5️⃣ الأدعية
  Widget _buildDuaa() {
    if (data is! Map) {
      return const Center(
        child: Text('خطأ في تحميل البيانات'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // العنوان
        SpecialHeaderCard(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
        ),

        const SizedBox(height: 10),

        // الأحاديث
        ...List.generate(
          data['references'].length,
          (index) {
            final ref = data['references'][index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: DuaHadithCard(
                source: ref['hadith_source'] ?? '',
                text: ref['text'] ?? '',
              ),
            );
          },
        ),
      ],
    );
  }
}

class DuaHadithCard extends StatelessWidget {
  const DuaHadithCard({
    required this.source,
    required this.text,
    super.key,
  });
  final String source;
  final String text;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
          Text(
            source,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(height: 1.8),
          ),
        ],
      ),
    );
  }
}

class SpecialHeaderCard extends StatelessWidget {
  const SpecialHeaderCard({
    required this.description,
    required this.title,
    super.key,
  });
  final String description;
  final String title;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(height: 1.8),
          ),
        ],
      ),
    );
  }
}
