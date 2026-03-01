import 'package:flutter/material.dart';
import 'package:sakina_app/features/names_of_allah/data/models/god_names_category_model.dart';
import 'package:sakina_app/features/names_of_allah/presentation/views/widgets/god_names_item.dart';

class GodNamesGridView extends StatelessWidget {
  const GodNamesGridView({
    required this.categories,
    super.key,
  });

  final List<GodNamesCategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemCount: categories.length,

      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GodNamesItem(category: category),
        );
      },
    );
  }
}
