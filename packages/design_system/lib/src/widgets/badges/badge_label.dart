import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class BadgeLabel extends StatelessWidget {
  final String label;

  const BadgeLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.dimensions.dimensionSm,
        vertical: context.dimensions.dimensionXxs,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(
          alpha: AppOpacity.HIGH_EMPHASIS,
        ),
        borderRadius: AppRadius.RADIUS_XS,
      ),
      child: Text(label, style: context.typography.labelSmall),
    );
  }
}
