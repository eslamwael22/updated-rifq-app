import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_images/app_icons/app_icons.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/core/constants/keys.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/core/helper/shared_prefs.dart';
import 'package:sakina_app/core/widgets/app_background.dart';
import 'package:sakina_app/core/widgets/custom_image_container.dart';
import 'package:sakina_app/features/location_permission/presentation/views/widgets/custom_location_button.dart';
import 'package:sakina_app/features/location_permission/presentation/views/widgets/custom_location_list_view.dart';
import 'package:sakina_app/features/location_permission/presentation/views/widgets/custom_location_static_text.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class LocationPermissionViewBody extends StatelessWidget {
  const LocationPermissionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return AppBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomImageContainer(
              borderRadius: 32,
              padding: 28,
              image: AppIcons.iconsBigLocation,
            ),
            const SizedBox(height: 24),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                locale.identifyLocationTitle,
                textAlign: TextAlign.center,
                style: AppStyles.textMedium30(
                  context,
                ),
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                locale.identifyLocationSubTitle,
                textAlign: TextAlign.center,
                style: AppStyles.textRegular16(
                  context,
                ),
              ),
            ),
            SizedBox(height: 32),
            CustomLocationListView(),
            const SizedBox(height: 32),
            CustomLocationButton(locale: locale),
            const SizedBox(
              height: 26,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.homeView);
                SharedPref.setBool(AppKeys.locationSkip, true);
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  locale.skipText,
                  style: AppStyles.textMedium18(context),
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            CustomLocationStaticText(locale: locale),
          ],
        ),
      ),
    );
  }
}
