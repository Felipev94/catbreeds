import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/spacing.dart';

class CardTitleSection extends StatelessWidget {
  final String title;
  final String? subtitle;

  const CardTitleSection({required this.title, this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: typography.titleMedium?.copyWith(color: colors.textPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.XXS),
          Text(
            subtitle!,
            style: typography.bodySmall?.copyWith(color: colors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
