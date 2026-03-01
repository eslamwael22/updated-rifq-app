import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/loading/custom_loading.dart';
import 'package:sakina_app/features/duas/presentation/manager/cubit/duas_cubit.dart';
import 'package:sakina_app/features/duas/presentation/views/widgets/prayers_card.dart';

class PrayersList extends StatelessWidget {
  const PrayersList({
    required this.isDark,
    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuasCubit, DuasState>(
      builder: (context, state) {
        if (state is DuasSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PrayersCard(
                    isDark: isDark,
                    model: state.prayersList[index],
                  ),
                );
              },
              childCount: state.prayersList.length,
            ),
          );
        } else if (state is DuasFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else {
          return AppShimmerLoading(
            padding: 0,
            isSliver: true,
            itemCount: 10,
          );
        }
      },
    );
  }
}
