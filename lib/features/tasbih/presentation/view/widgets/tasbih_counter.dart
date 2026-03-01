import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/extensions/context_size.dart';
import 'package:sakina_app/core/widgets/custom_container_decorate.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_state.dart';

class TasbihCounter extends StatelessWidget {
  const TasbihCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbihCubit, TasbihState>(
      buildWhen: (p, c) =>
          p.count != c.count || p.zakar != c.zakar || p.target != c.target,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                state.zakar,
                textAlign: TextAlign.center,
                style: AppStyles.textRegular30(
                  context,
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: .1,
                      child: CustomContainerDecorate(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: LightAppColors.greenColor0D7,
                        width: 8,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          '${state.count}',
                          style: AppStyles.textRegular72(
                            context,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'من ${state.target}',
                          style:
                              AppStyles.textRegular14(
                                context,
                              ).copyWith(
                                height: 1.43,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            width: context.uiWidth * .2,
                            child: LinearProgressIndicator(
                              value: state.count / state.target,
                              color: LightAppColors.greenColor0D7,
                              backgroundColor: const Color(0xFFE1E1E1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                LightAppColors.greenColor0D7,
                              ),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
