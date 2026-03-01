import 'package:flutter/material.dart';

class GodNamesCategoryModel {
  final String id;
  final String title;
  final String assetPath;
  final IconData icon;
  final List<Color> colors;

  GodNamesCategoryModel({
    required this.colors,
    required this.id,
    required this.title,
    required this.assetPath,
    required this.icon,
  });
}
