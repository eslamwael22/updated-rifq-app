import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/widgets/custom_button.dart';
import 'package:sakina_app/features/tasbih/presentation/manager/tasbih_cubit.dart';

void showCustomResetDialog(BuildContext blocContext) {
  final isDark = Theme.of(blocContext).brightness == Brightness.dark;
  showDialog(
    context: blocContext,
    builder: (context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Center(
            child: Dialog(
              backgroundColor: isDark
                  ? DarkAppColors.surface
                  : LightAppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'إعادة التعيين',
                      style: AppStyles.textMedium24(context).copyWith(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'اختر ما تريد القيام به:',
                      textAlign: TextAlign.center,
                      style: AppStyles.textRegular16(context).copyWith(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .3,
                          child: CustomButton(
                            title: 'الغاء',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .32,
                          child: CustomButton(
                            title: 'تصفير العداد',
                            onPressed: () {
                              blocContext.read<TasbihCubit>().reset();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      title: 'إعادة كل شيء',
                      onPressed: () {
                        blocContext.read<TasbihCubit>().resetAll();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
