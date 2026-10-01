import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';
import 'skeleton_box.dart';

class DetailSkeleton extends StatelessWidget {
  static const double DEFAULT_BANNER_HEIGHT = AppSpacing.XXXL * 4;
  static const double _TITLE_HEIGHT = AppSpacing.LG;
  static const double _SUBTITLE_HEIGHT = AppSpacing.SM + AppSpacing.XS;
  static const double _LINE_HEIGHT = AppSpacing.SM + AppSpacing.XS;
  static const double _TAG_WIDTH = AppSpacing.XXXL + AppSpacing.MD;
  static const double _TAG_HEIGHT = AppSpacing.LG;

  final double bannerHeight;

  const DetailSkeleton({
    this.bannerHeight = DEFAULT_BANNER_HEIGHT,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SkeletonBox(
          height: bannerHeight,
          borderRadius: BorderRadius.zero,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(context.dimensions.dimensionMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(
                  width: AppSpacing.XXXL * 3,
                  height: _TITLE_HEIGHT,
                  borderRadius: AppRadius.RADIUS_SM,
                ),
                SizedBox(height: context.dimensions.dimensionXs),
                SkeletonBox(
                  width: AppSpacing.XXXL * 2,
                  height: _SUBTITLE_HEIGHT,
                  borderRadius: AppRadius.RADIUS_SM,
                ),
                SizedBox(height: context.dimensions.dimensionMd),
                Row(
                  children: [
                    SkeletonBox(
                      width: _TAG_WIDTH,
                      height: _TAG_HEIGHT,
                      borderRadius: AppRadius.RADIUS_XS,
                    ),
                    SizedBox(width: context.dimensions.dimensionSm),
                    SkeletonBox(
                      width: _TAG_WIDTH,
                      height: _TAG_HEIGHT,
                      borderRadius: AppRadius.RADIUS_XS,
                    ),
                  ],
                ),
                SizedBox(height: context.dimensions.dimensionLg),
                Container(
                  padding: EdgeInsets.all(context.dimensions.dimensionMd),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: AppRadius.RADIUS_LG,
                  ),
                  child: Column(
                    children: [
                      SkeletonBox(height: _LINE_HEIGHT),
                      SizedBox(height: context.dimensions.dimensionSm),
                      SkeletonBox(height: _LINE_HEIGHT),
                      SizedBox(height: context.dimensions.dimensionSm),
                      SkeletonBox(
                        width: AppSpacing.XXXL * 3,
                        height: _LINE_HEIGHT,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.dimensions.dimensionMd),
                Container(
                  padding: EdgeInsets.all(context.dimensions.dimensionMd),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: AppRadius.RADIUS_LG,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SkeletonBox(
                            width: AppSpacing.XXXL,
                            height: _LINE_HEIGHT,
                          ),
                          const Spacer(),
                          SkeletonBox(
                            width: AppSpacing.XXXL,
                            height: _LINE_HEIGHT,
                          ),
                        ],
                      ),
                      SizedBox(height: context.dimensions.dimensionSm),
                      Row(
                        children: [
                          SkeletonBox(
                            width: AppSpacing.XXXL,
                            height: _LINE_HEIGHT,
                          ),
                          const Spacer(),
                          SkeletonBox(
                            width: AppSpacing.XXXL,
                            height: _LINE_HEIGHT,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
