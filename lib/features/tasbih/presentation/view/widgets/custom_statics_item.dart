import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_state.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_reset.dart';
import 'package:sakina_app/features/tasbih/presentation/view/widgets/custom_tasbih_section_count.dart';

class CustomStaticsItem extends StatelessWidget {
  const CustomStaticsItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<TasbihCubit, TasbihState>(
            buildWhen: (p, c) => p.round != c.round,
            builder: (context, state) {
              return CustomTasbihSectionCount(
                title: state.round.toString(),
                subTitle: 'الجولات',
              );
            },
          ),
          BlocBuilder<TasbihCubit, TasbihState>(
            buildWhen: (p, c) => p.fullCount != c.fullCount,
            builder: (context, state) {
              return CustomTasbihSectionCount(
                title: state.fullCount.toString(),
                subTitle: 'الاجمالي اليوم',
              );
            },
          ),
          CustomReset(),
        ],
      ),
    );
  }
}
