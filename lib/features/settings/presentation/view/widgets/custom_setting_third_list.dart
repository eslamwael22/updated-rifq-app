import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/extensions/context_size.dart';
import 'package:sakina_app/features/settings/presentation/view/models/setting_model.dart';
import 'package:sakina_app/features/settings/presentation/view/widgets/custom_setting_list_tile.dart';
import 'package:sakina_app/features/settings/presentation/view/widgets/custom_settings_item_container.dart';
import 'package:sakina_app/features/settings/presentation/view/privacy_policy_page.dart';
import 'package:sakina_app/features/settings/presentation/view/terms_conditions_page.dart';
import 'package:sakina_app/features/settings/presentation/view/about_app_page.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_divider.dart';

class CustomSettingThirdList extends StatelessWidget {
  const CustomSettingThirdList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomSettingsItemContainer(
        child: Column(
          children: List.generate(
            SettingModel.thirdSettingList.length,
            (index) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsConditionsPage(),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutAppPage(),
                        ),
                      );
                    }
                  },
                  child: CustomSettingListTile(
                    setting: SettingModel.thirdSettingList[index],
                  ),
                ),
                Visibility(
                  visible: index != SettingModel.thirdSettingList.length - 1,
                  child: Opacity(
                    opacity: .2,
                    child: CustomDivider(
                      color: LightAppColors.greenColor0D7,
                      endIndent: context.uiWidth * .03,
                      indent: context.uiWidth * .03,
                    ),
                  ),
                ),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }
}
