import 'package:flutter/material.dart';
import 'package:sakina_app/features/azkar/data/models/zekr_model.dart';

class CategoryModel {
  final List<Color> colors;
  final String imogi;
  final String title;
  late final int subTitle = zekrList.length;
  final List<ZekrModel> zekrList;

  CategoryModel({
    required this.zekrList,
    required this.colors,
    required this.imogi,
    required this.title,
  });
}