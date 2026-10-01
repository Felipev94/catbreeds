import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatsSkeletonView extends StatelessWidget {
  static const int _itemCount = 6;

  const CatsSkeletonView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          for (int i = 0; i < _itemCount; i++) ...[
            Padding(
              padding: EdgeInsets.all(context.dimensions.dimensionSm),
              child: const InfoCardSkeleton(),
            ),
            if (i < _itemCount - 1)
              Padding(
                padding: EdgeInsetsGeometry.all(context.dimensions.dimensionSm),
                child: Divider(color: context.colors.borderFocus),
              ),
          ],
        ],
      ),
    );
  }
}
