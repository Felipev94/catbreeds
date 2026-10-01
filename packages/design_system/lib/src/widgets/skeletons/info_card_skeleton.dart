import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/elevations.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';
import 'skeleton_box.dart';

class InfoCardSkeleton extends StatelessWidget {
  static const double _IMAGE_PANEL_WIDTH = AppSpacing.XXXL + AppSpacing.MD;
  static const double _TITLE_HEIGHT = AppSpacing.SM + AppSpacing.XS;
  static const double _LABEL_HEIGHT = AppSpacing.SM + AppSpacing.XXS + 1;
  static const double _SUBTITLE_WIDTH = AppSpacing.XXXL + AppSpacing.MD;
  static const double _VALUE_WIDTH_SHORT = AppSpacing.XXXL + AppSpacing.SM;
  static const double _VALUE_WIDTH_LONG = AppSpacing.XXXL + AppSpacing.XL;
  static const double _CHEVRON_SIZE = AppSpacing.LG + AppSpacing.XS;
  static const double _LABEL_WIDTH = AppSpacing.XXXL + AppSpacing.MD;

  const InfoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;

    return Material(
      color: colors.surface,
      borderRadius: AppRadius.RADIUS_LG,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppRadius.RADIUS_LG,
          boxShadow: isDark ? AppShadows.DARK_LEVEL_1 : AppShadows.LIGHT_LEVEL_2,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SkeletonBox(
                width: _IMAGE_PANEL_WIDTH,
                borderRadius: BorderRadius.zero,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.MD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonBox(height: _TITLE_HEIGHT),
                                const SizedBox(height: AppSpacing.XS),
                                SkeletonBox(
                                  width: _SUBTITLE_WIDTH,
                                  height: _LABEL_HEIGHT,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.SM),
                          const SkeletonBox(
                            width: _CHEVRON_SIZE,
                            height: _CHEVRON_SIZE,
                            borderRadius: AppRadius.RADIUS_FULL,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.SM),
                      _DetailRowSkeleton(
                        labelWidth: _LABEL_WIDTH,
                        valueWidth: _VALUE_WIDTH_SHORT,
                        height: _LABEL_HEIGHT,
                      ),
                      const SizedBox(height: AppSpacing.XXS),
                      _DetailRowSkeleton(
                        labelWidth: _LABEL_WIDTH,
                        valueWidth: _VALUE_WIDTH_LONG,
                        height: _LABEL_HEIGHT,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRowSkeleton extends StatelessWidget {
  final double labelWidth;
  final double valueWidth;
  final double height;

  const _DetailRowSkeleton({
    required this.labelWidth,
    required this.valueWidth,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonBox(width: labelWidth, height: height),
        const Spacer(),
        SkeletonBox(width: valueWidth, height: height),
      ],
    );
  }
}
