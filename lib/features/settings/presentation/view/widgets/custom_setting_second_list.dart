import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/extensions/context_size.dart';
import 'package:sakina_app/features/settings/presentation/view/models/setting_model.dart';
import 'package:sakina_app/features/settings/presentation/view/widgets/custom_setting_list_tile.dart';
import 'package:sakina_app/features/settings/presentation/view/widgets/custom_settings_item_container.dart';
import 'package:sakina_app/features/splash/presentation/view/widgets/custom_divider.dart';

class CustomSettingSecondList extends StatelessWidget {
  const CustomSettingSecondList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomSettingsItemContainer(
        child: Column(
          children: List.generate(
            SettingModel.secondSettingList.length,
            (index) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.pushNamed(context, AppRoutes.quranSettingsView);
                    } else if (index == 1) {
                      Navigator.pushNamed(context, AppRoutes.quranSettingsView);
                    }
                  },
                  child: CustomSettingListTile(
                    setting: SettingModel.secondSettingList[index],
                  ),
                ),
                Visibility(
                  visible: index != SettingModel.secondSettingList.length - 1,
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
