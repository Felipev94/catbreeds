import 'dart:math' as math;

import 'package:design_system/src/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ScaffoldTemplate extends StatelessWidget {
  final Widget? expandedHeader;
  final Widget? shrinkingHeader;
  final Widget? leadingHeader;
  final Widget? trailingHeader;
  final List<Widget> content;

  const ScaffoldTemplate({
    required this.content,
    this.expandedHeader,
    this.shrinkingHeader,
    this.leadingHeader,
    this.trailingHeader,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: RawScrollbar(
        thumbColor: context.colors.borderFocus,
        radius: Radius.circular(context.dimensions.dimensionXs),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CollapsibleHeaderDelegate(
                minHeight: kToolbarHeight + 80,
                maxHeight: 200,
                expandedChild: expandedHeader,
                leadingWidget: leadingHeader,
                trailingWidget: trailingHeader,
                shrinkingChild: shrinkingHeader,
              ),
            ),
            ...content,
          ],
        ),
      ),
    );
  }
}

class CollapsibleHeaderDelegate extends SliverPersistentHeaderDelegate {
  static const double _LOWER_LIMIT_CLAMP = 0.0;
  static const double _UPPER_LIMIT_CLAMP = 1.0;
  static const double _IGNORE_RATIO_LIMIT = 0.2;
  static const double _MIN_EXPANDED_HEIGHT = 0.0;
  static const double _ACTIONS_SAVE_AREA = 80.0;
  static const double _MAX_TOP_PADDING_POSITION = 72.0;

  final double minHeight;
  final double maxHeight;
  final Widget? expandedChild;
  final Widget? shrinkingChild;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  const CollapsibleHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.expandedChild,
    required this.shrinkingChild,
    this.leadingWidget,
    this.trailingWidget,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double maxExtentDiff = maxHeight - minHeight;

    final double expandRatio =
        (_UPPER_LIMIT_CLAMP - (shrinkOffset / maxExtentDiff)).clamp(
          _LOWER_LIMIT_CLAMP,
          _UPPER_LIMIT_CLAMP,
        );

    final double horizontalPadding = EdgeInsets.lerp(
      EdgeInsets.symmetric(horizontal: _ACTIONS_SAVE_AREA),
      EdgeInsets.symmetric(horizontal: context.dimensions.dimensionMd),
      expandRatio,
    )!.left;

    final double topPadding = math.max(
      MediaQuery.of(context).padding.top + context.dimensions.dimensionXs,
      (maxHeight - shrinkOffset) - _MAX_TOP_PADDING_POSITION,
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.dimensions.dimensionMd),
          bottomRight: Radius.circular(context.dimensions.dimensionMd),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (expandedChild != null)
            Positioned(
              top:
                  MediaQuery.of(context).padding.top +
                  context.dimensions.dimensionMd,
              left: context.dimensions.dimensionMd,
              right: context.dimensions.dimensionMd,
              bottom: context.dimensions.dimensionXxxl,
              child: Opacity(
                opacity: expandRatio * expandRatio * expandRatio,
                child: IgnorePointer(
                  ignoring: expandRatio < _IGNORE_RATIO_LIMIT,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: .topCenter,
                      minHeight: _MIN_EXPANDED_HEIGHT,
                      maxHeight: maxHeight,
                      child: expandedChild,
                    ),
                  ),
                ),
              ),
            ),
          if (shrinkingChild != null)
            Positioned(
              top: topPadding,
              left: horizontalPadding,
              right: horizontalPadding,
              child: shrinkingChild!,
            ),
          Positioned(
            top:
                MediaQuery.of(context).padding.top +
                context.dimensions.dimensionMd,
            left: context.dimensions.dimensionMd,
            right: context.dimensions.dimensionMd,
            bottom: context.dimensions.dimensionXxxl,
            child: Row(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                leadingWidget ?? SizedBox.shrink(),
                trailingWidget ?? SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant CollapsibleHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        expandedChild != oldDelegate.expandedChild ||
        shrinkingChild != oldDelegate.shrinkingChild;
  }
}
