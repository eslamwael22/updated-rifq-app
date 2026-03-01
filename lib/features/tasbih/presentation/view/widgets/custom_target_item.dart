import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_state.dart';

class CustomTargetItem extends StatelessWidget {
  const CustomTargetItem({
    required this.isDark,
    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbihCubit, TasbihState>(
      buildWhen: (previous, current) => previous.target != current.target,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'عدد التسبيحات المطلوب: ${state.target}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Slider(
              value: state.target.toDouble(),
              min: 1,
              max: 500,
              divisions: 499,
              onChanged: (value) {
                context.read<TasbihCubit>().changeTarget(value.toInt());
              },
            ),
          ],
        );
      },
    );
  }
}
