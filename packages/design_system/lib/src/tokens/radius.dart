import 'package:flutter/widgets.dart';

abstract final class AppRadius {
  static const double NONE = 0.0;
  static const double XS = 4.0;
  static const double SM = 8.0;
  static const double MD = 12.0;
  static const double LG = 16.0;
  static const double XL = 24.0;
  static const double XXL = 32.0;
  static const double FULL = 999.0;

  static const Radius CIRCULAR_NONE = Radius.zero;
  static const Radius CIRCULAR_XS = Radius.circular(XS);
  static const Radius CIRCULAR_SM = Radius.circular(SM);
  static const Radius CIRCULAR_MD = Radius.circular(MD);
  static const Radius CIRCULAR_LG = Radius.circular(LG);
  static const Radius CIRCULAR_XL = Radius.circular(XL);
  static const Radius CIRCULAR_XXL = Radius.circular(XXL);
  static const Radius CIRCULAR_FULL = Radius.circular(FULL);

  static const BorderRadius RADIUS_NONE = BorderRadius.zero;
  static const BorderRadius RADIUS_XS = BorderRadius.all(CIRCULAR_XS);
  static const BorderRadius RADIUS_SM = BorderRadius.all(CIRCULAR_SM);
  static const BorderRadius RADIUS_MD = BorderRadius.all(CIRCULAR_MD);
  static const BorderRadius RADIUS_LG = BorderRadius.all(CIRCULAR_LG);
  static const BorderRadius RADIUS_XL = BorderRadius.all(CIRCULAR_XL);
  static const BorderRadius RADIUS_XXL = BorderRadius.all(CIRCULAR_XXL);
  static const BorderRadius RADIUS_FULL = BorderRadius.all(CIRCULAR_FULL);

  static const BorderRadius SHEET_TOP = BorderRadius.vertical(top: CIRCULAR_XL);
}
