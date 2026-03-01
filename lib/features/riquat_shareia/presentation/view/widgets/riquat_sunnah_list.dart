import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/loading/custom_loading.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/manager/riquat_sunnah_cubit/riquat_sunnah_cubit.dart';
import 'package:sakina_app/features/riquat_shareia/presentation/view/widgets/riquat_sunnah_item.dart';

class RiquatSunnahList extends StatelessWidget {
  const RiquatSunnahList({
    required this.isDark,
    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiquatSunnahCubit, RiquatSunnahState>(
      builder: (context, state) {
        if (state is RiquatSunnahSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RiquatSunnahItem(
                    isDark: isDark,
                    model: state.riquatList[index],
                  ),
                );
              },
              childCount: state.riquatList.length,
            ),
          );
        } else if (state is RiquatSunnahFailure) {
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
