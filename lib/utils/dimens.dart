import 'package:flutter/material.dart';

class Dimens {
  Dimens._();
  static late double _screenWidth;
  static late double _screenHeight;
  static late EdgeInsets _padding;

  static const double borderRadius = 10.0;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _padding = MediaQuery.of(context).padding;
  }

  static double get screenWidth => _screenWidth;
  static EdgeInsets get padding => _padding;

  static double get screenHeight => _screenHeight;
}
