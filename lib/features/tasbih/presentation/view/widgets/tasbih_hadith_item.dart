import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_divider.dart';

class TasbihHadithItem extends StatelessWidget {
  const TasbihHadithItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundGradient = isDark
        ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DarkAppColors.card.withOpacity(0.9),
              DarkAppColors.card,
            ],
          )
        : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4E5C2), Color(0xFFE8D7B0)],
          );

    final borderColor = isDark
        ? DarkAppColors.primaryColor
        : const Color(0xFFD4AF37);
    final starColor = isDark
        ? DarkAppColors.primaryColor
        : const Color(0xFFD4AF37);
    final textColorPrimary = isDark
        ? DarkAppColors.textPrimary
        : LightAppColors.blackColor1A;
    final textColorSecondary = isDark
        ? DarkAppColors.textSecondary
        : LightAppColors.greyColor6B;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: backgroundGradient,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                color: starColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Icon(Icons.star, color: LightAppColors.whiteColor),
            ),
            const SizedBox(height: 8),
            Text(
              'فضل التسبيح',
              textAlign: TextAlign.center,
              style: AppStyles.textRegular14(
                context,
              ).copyWith(height: 1.43, color: textColorSecondary),
            ),
            const SizedBox(height: 8),
            CustomDivider(),
            const SizedBox(height: 8),
            Text(
              '"مَنْ قَالَ سُبْحَانَ اللَّهِ وَبِحَمۡدِهِ فِي يَوۡمٍ مِائَةَ مَرَّةٍ حُطَّتۡ خَطَايَاهُ وَإِنۡ كَانَتۡ مِثۡلَ زَبَدِ ٱلۡبَحۡرِ"',
              textAlign: TextAlign.center,
              style: AppStyles.textRegular16Amiri(
                context,
              ).copyWith(color: textColorPrimary),
            ),
            const SizedBox(height: 8),
            CustomDivider(),
            const SizedBox(height: 8),
            Text(
              'رواه البخاري ومسلم',
              textAlign: TextAlign.center,
              style: AppStyles.textRegular12(
                context,
              ).copyWith(color: textColorSecondary, height: 1.33),
            ),
          ],
        ),
      ),
    );
  }
}
