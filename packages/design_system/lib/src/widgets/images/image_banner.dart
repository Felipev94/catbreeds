import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/spacing.dart';
import '../badges/badge_label.dart';
import 'image_panel.dart';

class ImageBanner extends StatelessWidget {
  static const double DEFAULT_HEIGHT = AppSpacing.XXXL * 4;

  final String? imageUrl;
  final String? badge;
  final double height;
  final Widget? placeholder;
  final BoxFit fit;

  const ImageBanner({
    required this.imageUrl,
    this.badge,
    this.height = DEFAULT_HEIGHT,
    this.placeholder,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surfaceContainer,
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: CachedNetworkImageProvider(imageUrl ?? ''),
            fit: fit,
            errorBuilder: (_, _, _) =>
                placeholder ?? const DefaultImagePlaceholder(),
          ),
          if (badge != null)
            Positioned(
              left: context.dimensions.dimensionMd,
              bottom: context.dimensions.dimensionMd,
              child: BadgeLabel(label: badge!),
            ),
        ],
      ),
    );
  }
}
