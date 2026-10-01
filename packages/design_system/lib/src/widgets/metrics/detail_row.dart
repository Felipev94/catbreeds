import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';

class DetailData {
  final String label;
  final String value;

  const DetailData({required this.label, required this.value});
}

class DetailRow extends StatelessWidget {
  final DetailData detail;

  const DetailRow({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          detail.label,
          style: context.typography.bodySmall?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(detail.value, style: context.typography.labelSmall),
      ],
    );
  }
}
