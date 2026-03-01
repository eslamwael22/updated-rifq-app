import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;
}
