import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/azkar/data/models/zekr_model.dart';
import 'package:sakina_app/features/azkar/presentation/view/widgets/zekr_list_view.dart';

class AzkarDetailsViewBody extends StatelessWidget {
  const AzkarDetailsViewBody({required this.azkar, super.key});
  final List<ZekrModel> azkar;
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: ZekrListView(
                  azkarList: azkar,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
