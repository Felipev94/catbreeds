import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/spacing.dart';

class MetricData {
  final String label;
  final int value;
  final int maxRating;
  final IconData? icon;

  const MetricData({
    required this.label,
    required this.value,
    this.maxRating = 5,
    this.icon,
  });
}

class MetricRow extends StatelessWidget {
  static const int _DOT_COUNT = 5;
  static const double _DOT_SIZE = AppSpacing.SM;
  static const double _DOT_SPACING = AppSpacing.XXS + 1;
  static const double _ICON_SIZE = AppSpacing.SM + AppSpacing.XS;

  final MetricData metric;

  const MetricRow({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final int filled = metric.value.clamp(0, metric.maxRating);

    return Row(
      children: [
        if (metric.icon != null) ...[
          Icon(metric.icon, size: _ICON_SIZE, color: colors.textMuted),
          const SizedBox(width: AppSpacing.XS),
        ],
        Expanded(
          child: Text(
            metric.label,
            style: typography.labelSmall?.copyWith(color: colors.textSecondary),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_DOT_COUNT, (i) {
            final bool active = i < filled;
            return Padding(
              padding: const EdgeInsets.only(left: _DOT_SPACING),
              child: Container(
                width: _DOT_SIZE,
                height: _DOT_SIZE,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? colors.secondary : colors.borderSubtle,
                ),
              ),
            );
          }),
        ),
        const SizedBox(width: AppSpacing.XS),
        Text(
          '$filled/${metric.maxRating}',
          style: typography.labelSmall?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}
