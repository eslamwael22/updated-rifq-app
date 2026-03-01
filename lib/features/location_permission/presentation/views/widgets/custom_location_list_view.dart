import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_routes.dart';
import 'package:sakina_app/features/location_permission/data/models/location_model.dart';
import 'package:sakina_app/features/location_permission/presentation/views/widgets/custom_location_list_tile.dart';

class CustomLocationListView extends StatelessWidget {
  const CustomLocationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        LocationModel.locationList(context: context).length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == 2 ? 0 : 12),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.tasbihView);
            },
            child: CustomLocationListTile(
              locationModel: LocationModel.locationList(
                context: context,
              )[index],
            ),
          ),
        ),
      ),
    );
  }
}
