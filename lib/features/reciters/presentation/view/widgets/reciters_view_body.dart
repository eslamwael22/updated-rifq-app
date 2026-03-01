import 'package:flutter/material.dart';
import 'package:sakina_app/core/widgets/custom_app_bar.dart';
import 'package:sakina_app/features/reciters/presentation/view/widgets/reciters_list.dart';

class RecitersViewBody extends StatelessWidget {
  const RecitersViewBody({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          isShow: false,
          title: 'اختيار القارئ',
          subTitle: 'استمتع بأجمل وأعذب الأصوات في تلاوة القرآن الكريم',
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              RecitersList(isDark: isDark),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
