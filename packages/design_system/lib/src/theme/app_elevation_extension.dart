import 'package:flutter/material.dart';

import '../tokens/elevations.dart';

class AppElevationExtension extends ThemeExtension<AppElevationExtension> {
  const AppElevationExtension({
    required this.level0,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
  });

  final List<BoxShadow> level0;
  final List<BoxShadow> level1;
  final List<BoxShadow> level2;
  final List<BoxShadow> level3;
  final List<BoxShadow> level4;
  final List<BoxShadow> level5;

  static const AppElevationExtension light = AppElevationExtension(
    level0: AppShadows.LIGHT_LEVEL_0,
    level1: AppShadows.LIGHT_LEVEL_1,
    level2: AppShadows.LIGHT_LEVEL_2,
    level3: AppShadows.LIGHT_LEVEL_3,
    level4: AppShadows.LIGHT_LEVEL_4,
    level5: AppShadows.LIGHT_LEVEL_5,
  );

  static const AppElevationExtension dark = AppElevationExtension(
    level0: AppShadows.DARK_LEVEL_0,
    level1: AppShadows.DARK_LEVEL_1,
    level2: AppShadows.DARK_LEVEL_2,
    level3: AppShadows.DARK_LEVEL_3,
    level4: AppShadows.DARK_LEVEL_4,
    level5: AppShadows.DARK_LEVEL_5,
  );

  @override
  AppElevationExtension copyWith({
    List<BoxShadow>? level0,
    List<BoxShadow>? level1,
    List<BoxShadow>? level2,
    List<BoxShadow>? level3,
    List<BoxShadow>? level4,
    List<BoxShadow>? level5,
  }) {
    return AppElevationExtension(
      level0: level0 ?? this.level0,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
    );
  }

  @override
  AppElevationExtension lerp(
    ThemeExtension<AppElevationExtension>? other,
    double t,
  ) {
    if (other is! AppElevationExtension) return this;
    if (t < 0.5) return this;
    return other;
  }
}
