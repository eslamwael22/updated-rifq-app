import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void changeTheme() {
    final res = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    emit(res);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool?;
    if (isDark == null) {
      return ThemeMode.light;
    }
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'isDark': state == ThemeMode.dark};
  }
}
