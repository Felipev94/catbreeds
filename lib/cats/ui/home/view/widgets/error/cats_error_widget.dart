import 'package:catbreeds/app/ui/l10n/extension/l10n_extension.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatsErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const CatsErrorWidget({required this.onRetry, this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: ErrorTemplate(
        title: context.l10n.catsErrorTitle,
        message: message,
        retryLabel: context.l10n.catsErrorRetry,
        onRetry: onRetry,
      ),
    );
  }
}
