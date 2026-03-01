import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_state.dart';

class TasbihButton extends StatelessWidget {
  const TasbihButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbihCubit, TasbihState>(
      buildWhen: (p, c) => p.count != c.count,
      builder: (context, state) {
        return GestureDetector(
          onTap: state.isCompleted
              ? null
              : () => context.read<TasbihCubit>().increment(),
          child: Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, 0.00),
                end: Alignment(0.50, 1.00),
                colors: const [Color(0xFF0D7E5E), Color(0xFF0A6349)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33554400),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    'تسبيح',
                    style: AppStyles.textMedium24(context).copyWith(
                      color: state.isCompleted
                          ? Colors.grey.shade600
                          : Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'اضغط للعد',
                    style: AppStyles.textMedium12(
                      context,
                    ).copyWith(color: LightAppColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
