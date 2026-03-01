import 'package:flutter/material.dart';
import 'package:sakina_app/core/constants/app_colors/dark_app_colors.dart';
import 'package:sakina_app/core/constants/app_colors/light_app_colors.dart';

class CustomFavIcon extends StatefulWidget {
  const CustomFavIcon({required this.iconSize, super.key});
  final double iconSize;
  @override
  State<CustomFavIcon> createState() => _CustomFavIconState();
}

bool isFav = false;

class _CustomFavIconState extends State<CustomFavIcon> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },
      child: isFav
          ? Icon(
              Icons.favorite_rounded,
              color: Colors.red,
              size: widget.iconSize,
            )
          : Icon(
              Icons.favorite_border_outlined,
              color: isDark
                  ? DarkAppColors.primaryLight
                  : LightAppColors.primaryColor,
              size: widget.iconSize,
            ),
    );
  }
}