import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ErrorTemplate extends StatelessWidget {
  static const double _DEFAULT_IMAGE_SIZE =
      AppSpacing.XXXL + AppSpacing.XXXL + AppSpacing.XXXL + AppSpacing.XL;

  final String title;
  final String? message;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final double imageSize;

  const ErrorTemplate({
    super.key,
    required this.title,
    this.message,
    this.retryLabel,
    this.onRetry,
    this.imageSize = _DEFAULT_IMAGE_SIZE,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dimensions.dimensionXl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AppImages.errorImage,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            ),
            SizedBox(height: context.dimensions.dimensionLg),
            Text(
              title,
              style: context.typography.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: context.dimensions.dimensionSm),
              Text(
                message!,
                style: context.typography.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (retryLabel != null) ...[
              SizedBox(height: context.dimensions.dimensionXl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onRetry,
                  child: Text(retryLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
