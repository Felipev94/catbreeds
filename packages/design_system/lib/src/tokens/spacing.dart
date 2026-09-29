import 'package:flutter/widgets.dart';


abstract final class AppSpacing {
  static const double NONE = 0.0;
  static const double XXS = 2.0;
  static const double XS = 4.0;
  static const double SM = 8.0;
  static const double MD = 16.0;
  static const double LG = 24.0;
  static const double XL = 32.0;
  static const double XXL = 48.0;
  static const double XXXL = 64.0;

  static const EdgeInsets INSETS_NONE = EdgeInsets.zero;
  static const EdgeInsets INSETS_XXS = EdgeInsets.all(XXS);
  static const EdgeInsets INSETS_XS = EdgeInsets.all(XS);
  static const EdgeInsets INSETS_SM = EdgeInsets.all(SM);
  static const EdgeInsets INSETS_MD = EdgeInsets.all(MD);
  static const EdgeInsets INSETS_LG = EdgeInsets.all(LG);
  static const EdgeInsets INSETS_XL = EdgeInsets.all(XL);
  static const EdgeInsets INSETS_XXL = EdgeInsets.all(XXL);

  static const EdgeInsets INSETS_H_SM = EdgeInsets.symmetric(horizontal: SM);
  static const EdgeInsets INSETS_H_MD = EdgeInsets.symmetric(horizontal: MD);
  static const EdgeInsets INSETS_H_LG = EdgeInsets.symmetric(horizontal: LG);

  static const EdgeInsets INSETS_V_XS = EdgeInsets.symmetric(vertical: XS);
  static const EdgeInsets INSETS_V_SM = EdgeInsets.symmetric(vertical: SM);
  static const EdgeInsets INSETS_V_MD = EdgeInsets.symmetric(vertical: MD);
  static const EdgeInsets INSETS_V_LG = EdgeInsets.symmetric(vertical: LG);
}

abstract final class AppLayout {
  static const double GUTTER = 16.0;
  static const double MARGIN = 16.0;
  static const double MAX_CONTENT_WIDTH = 1200.0;
  static const double MOBILE_BREAKPOINT = 600.0;
  static const double TABLET_BREAKPOINT = 900.0;

  static const EdgeInsets SCREEN_PADDING = EdgeInsets.symmetric(
    horizontal: MARGIN,
  );
  static const EdgeInsets CARD_PADDING = EdgeInsets.all(AppSpacing.MD);
  static const EdgeInsets DIALOG_PADDING = EdgeInsets.all(AppSpacing.LG);
}
