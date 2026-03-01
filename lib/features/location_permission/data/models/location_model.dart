import 'package:flutter/material.dart';
import 'package:sakina_app/l10n/app_localizations.dart';

class LocationModel {
  final IconData icon;
  final String title;
  final String subTitle;

  LocationModel({
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  static List<LocationModel> locationList({required BuildContext context}) {
    final locale = AppLocalizations.of(context)!;

    return [
      LocationModel(
        icon: Icons.explore,
        title: locale.firstLocationListTile,
        subTitle: locale.firstLocationListTileSubTitle,
      ),

      LocationModel(
        icon: Icons.public,
        title: locale.secondLocationListTile,
        subTitle: locale.secondLocationListTileSubTitle,
      ),

      LocationModel(
        icon: Icons.privacy_tip_outlined,
        title: locale.thirdLocationListTile,
        subTitle: locale.thirdLocationListTileSubTitle,
      ),
    ];
  }
}
