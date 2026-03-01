import 'package:flutter/material.dart';

class SelectorModel {
  final String title;
  final Color unselectedTextColor;
  SelectorModel({required this.title, required this.unselectedTextColor});

  static List<SelectorModel> selectorList = [
    SelectorModel(
      title: 'الرقية من القرآن',
      unselectedTextColor: const Color(0xFFB0D2C5),
    ),
    SelectorModel(
      title: 'الرقية من السنة',
      unselectedTextColor: const Color(0xFFB0D2C5),
    ),
  ];
}
