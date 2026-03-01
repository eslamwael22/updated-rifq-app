import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/app_images/app_icons/app_icons.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class CustomLocationStaticText extends StatelessWidget {
  const CustomLocationStaticText({
    required this.locale,
    super.key,
  });

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            AppIcons.iconsPrivacy,
            height: 8,
            colorFilter: ColorFilter.mode(
              LightAppColors.greyColor6B,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              locale.selectionLocationSetting,
              textAlign: TextAlign.center,
              style: AppStyles.textRegular12(context),
            ),
          ),
        ),
      ],
    );
  }
}
