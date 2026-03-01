import 'package:flutter/material.dart';

extension ContextSize on BuildContext {
  double get uiWidth => MediaQuery.of(this).size.width;
  double get uiHeight => MediaQuery.of(this).size.height;
}
