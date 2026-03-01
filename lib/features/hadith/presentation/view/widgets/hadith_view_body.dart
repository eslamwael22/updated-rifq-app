import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/hadith_list.dart'
    show HadithList;

class HadithViewBody extends StatelessWidget {
  const HadithViewBody({required this.isDark, super.key});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          isShow: false,
          subTitle: 'شرح و تفسير الأربعين النووية',
          title: 'الأربعين النووية',
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              HadithList(isDark: isDark),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
