import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/widgets/custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
    this.isDark = false,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final iconColor = isDark ? Colors.red[300] : Colors.redAccent;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 80,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'عفوًا، حصل خطأ غير متوقع!',
              textAlign: TextAlign.center,
              style: AppStyles.textBold17(context).copyWith(color: textColor),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.textRegular18(
                context,
              ).copyWith(color: textColor),
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'إعادة المحاولة',
              onPressed: onRetry,
              style: AppStyles.textMedium20(context).copyWith(
                color: LightAppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
