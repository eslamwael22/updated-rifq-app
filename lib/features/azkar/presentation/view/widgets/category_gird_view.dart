import 'package:flutter/material.dart';
import 'package:sakina_app/features/azkar/data/models/category_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/azkar_details_view.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/category_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({required this.items, super.key});
  final List<CategoryModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: items.length,
        (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AzkarDetailsView(
                      zekr: items[index].zekrList,
                    );
                  },
                ),
              );
            },
            child: CategoryItem(
              categoryModel: items[index],
            ),
          ),
        ),
      ),
    );
  }
}
