import 'package:flutter/material.dart';

import '../tokens/spacing.dart';

class AppDimensionExtension extends ThemeExtension<AppDimensionExtension> {
  final double dimensionZero;
  final double dimensionXxs;
  final double dimensionXs;
  final double dimensionSm;
  final double dimensionMd;
  final double dimensionLg;
  final double dimensionXl;
  final double dimensionXxl;
  final double dimensionXxxl;

  const AppDimensionExtension({
    required this.dimensionZero,
    required this.dimensionXxs,
    required this.dimensionXs,
    required this.dimensionSm,
    required this.dimensionMd,
    required this.dimensionLg,
    required this.dimensionXl,
    required this.dimensionXxl,
    required this.dimensionXxxl,
  });

  static const AppDimensionExtension defaultDimensions = AppDimensionExtension(
    dimensionZero: AppSpacing.NONE,
    dimensionXxs: AppSpacing.XXS,
    dimensionXs: AppSpacing.XS,
    dimensionSm: AppSpacing.SM,
    dimensionMd: AppSpacing.MD,
    dimensionLg: AppSpacing.LG,
    dimensionXl: AppSpacing.XL,
    dimensionXxl: AppSpacing.XXL,
    dimensionXxxl: AppSpacing.XXXL,
  );

  @override
  AppDimensionExtension copyWith({
    double? dimensionZero,
    double? dimensionXxs,
    double? dimensionXs,
    double? dimensionSm,
    double? dimensionMd,
    double? dimensionLg,
    double? dimensionXl,
    double? dimensionXxl,
    double? dimensionXxxl,
  }) => AppDimensionExtension(
    dimensionZero: dimensionZero ?? this.dimensionZero,
    dimensionXxs: dimensionXxs ?? this.dimensionXxs,
    dimensionXs: dimensionXs ?? this.dimensionXs,
    dimensionSm: dimensionSm ?? this.dimensionSm,
    dimensionMd: dimensionMd ?? this.dimensionMd,
    dimensionLg: dimensionLg ?? this.dimensionLg,
    dimensionXl: dimensionXl ?? this.dimensionXl,
    dimensionXxl: dimensionXxl ?? this.dimensionXxl,
    dimensionXxxl: dimensionXxxl ?? this.dimensionXxxl,
  );

  @override
  AppDimensionExtension lerp(
    covariant ThemeExtension<AppDimensionExtension>? other,
    double t,
  ) {
    if (other is! AppDimensionExtension) return this;
    return other;
  }
}
