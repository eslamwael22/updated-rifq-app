import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';
import 'package:sakina_app/features/riquat_shareia/data/models/selector_model.dart';

class CustomTap extends StatelessWidget {
  const CustomTap({
    required this.isSelected,
    required this.segmentWidth,
    required this.item,
    super.key,
  });

  final double segmentWidth;
  final SelectorModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: segmentWidth,
      child: Center(
        child: Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSelected ? 17 : 15.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : LightAppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
