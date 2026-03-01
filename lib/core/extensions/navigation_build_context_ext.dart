import 'package:flutter/material.dart';

extension NavigationContextExt on BuildContext {
  Future<dynamic> pushPage(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<dynamic> pushReplacement(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }

  Future<Object?> pushNamed(String route) =>
      Navigator.of(this).pushNamed(route);
  Future<Object?> pushNamedAndRemoveUntil(String route) =>
      Navigator.of(this).pushNamedAndRemoveUntil(route, (route) => false);
}
