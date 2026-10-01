import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ChevronBadge extends StatelessWidget {
  const ChevronBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dimensions.dimensionLg,
      height: context.dimensions.dimensionLg,
      decoration: BoxDecoration(
        color: context.colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.chevron_right_rounded,
        size: context.dimensions.dimensionMd,
        color: context.colors.onPrimaryContainer,
      ),
    );
  }
}
