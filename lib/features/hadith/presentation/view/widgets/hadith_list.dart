import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/loading/custom_loading.dart';
import 'package:sakina_app/core/widgets/error_widget.dart';
import 'package:sakina_app/features/hadith/presentation/manager/cubit/hadith_cubit.dart';
import 'package:sakina_app/features/hadith/presentation/view/widgets/hadith_card.dart';

class HadithList extends StatelessWidget {
  const HadithList({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithSuccess) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final hadith = state.hadithList[index];
                return HadithCard(hadith: hadith, isDark: isDark);
              }, childCount: state.hadithList.length),
            ),
          );
        } else if (state is HadithFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(
              message: state.errorMessage,
              isDark: isDark,
              onRetry: () => context.read<HadithCubit>().loadHadith(),
            ),
          );
        } else {
          return AppShimmerLoading(
            isSliver: true,
            itemCount: 10,
          );
        }
      },
    );
  }
}
