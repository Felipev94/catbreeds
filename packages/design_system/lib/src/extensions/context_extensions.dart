import 'package:design_system/src/theme/app_dimension_extension.dart';
import 'package:flutter/material.dart';

import '../theme/app_color_extension.dart';
import '../theme/app_elevation_extension.dart';

extension DesignSystemContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get typography => theme.textTheme;

  AppColorExtension get colors =>
      theme.extension<AppColorExtension>() ??
      (isDarkMode ? AppColorExtension.dark : AppColorExtension.light);
  AppElevationExtension get elevations =>
      theme.extension<AppElevationExtension>() ??
      (isDarkMode ? AppElevationExtension.dark : AppElevationExtension.light);

  AppDimensionExtension get dimensions =>
      theme.extension<AppDimensionExtension>() ??
      AppDimensionExtension.defaultDimensions;

  bool get isDarkMode => theme.brightness == Brightness.dark;
}
