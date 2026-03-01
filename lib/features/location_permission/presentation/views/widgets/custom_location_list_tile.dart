import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/styles/app_styles.dart';
import 'package:sakina_app/features/location_permission/data/models/location_model.dart';

class CustomLocationListTile extends StatelessWidget {
  const CustomLocationListTile({
    required this.locationModel,
    super.key,
  });
  final LocationModel locationModel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark
          ? Color.fromRGBO(22, 32, 29, 1)
          : Color.fromRGBO(255, 255, 255, 1),
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2,
          color: isDark
              ? Color.fromRGBO(255, 255, 255, 0.1)
              : Color.fromRGBO(0, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Color.fromRGBO(13, 126, 94, 0.25),
                      Color.fromRGBO(13, 126, 94, 0),
                    ]
                  : [
                      Color.fromRGBO(13, 126, 94, 1),
                      Color.fromRGBO(0, 200, 140, 1),
                    ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              locationModel.icon,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          locationModel.title,
          style: AppStyles.textMedium16(context),
        ),
        subtitle: Text(
          locationModel.subTitle,
          style: AppStyles.textRegular12(context),
        ),
      ),
    );
  }
}
