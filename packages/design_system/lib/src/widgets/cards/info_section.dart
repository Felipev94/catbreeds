import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/elevations.dart';
import '../../tokens/radius.dart';

class InfoSection extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? trailing;

  const InfoSection({
    required this.child,
    this.title,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: AppRadius.RADIUS_LG,
        boxShadow: context.isDarkMode
            ? AppShadows.DARK_LEVEL_1
            : AppShadows.LIGHT_LEVEL_1,
      ),
      padding: EdgeInsets.all(context.dimensions.dimensionMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: context.typography.titleSmall?.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ?trailing,
              ],
            ),
            SizedBox(height: context.dimensions.dimensionSm),
          ],
          child,
        ],
      ),
    );
  }
}
