import 'package:flutter/material.dart';
import 'package:sakina_app/features/azkar/data/models/zekr_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/zekr_item.dart';

class ZekrListView extends StatelessWidget {
  const ZekrListView({required this.azkarList, super.key});
  final List<ZekrModel> azkarList;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: azkarList.length,
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: ZekrItem(
            zekrModel: azkarList[index],
          ),
        ),
      ),
    );
  }
}
