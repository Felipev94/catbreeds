import 'package:flutter/animation.dart';

abstract final class AppDurations {
  static const Duration INSTANT = Duration.zero;
  static const Duration FAST = Duration(milliseconds: 150);
  static const Duration NORMAL = Duration(milliseconds: 300);
  static const Duration SLOW = Duration(milliseconds: 500);
  static const Duration VERY_SLOW = Duration(milliseconds: 800);
}

abstract final class AppCurves {
  static const Curve STANDARD = Curves.easeInOut;
  static const Curve DECELERATE = Curves.decelerate;
  static const Curve ACCELERATE = Curves.easeIn;
  static const Curve EMPHASIZED = Curves.fastOutSlowIn;
}
