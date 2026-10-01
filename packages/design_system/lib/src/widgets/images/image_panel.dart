import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ImagePanel extends StatelessWidget {
  static const double DEFAULT_WIDTH = AppSpacing.XXXL + AppSpacing.XL;
  static const double DEFAULT_HEIGHT =
      AppSpacing.XXXL + AppSpacing.XXXL + AppSpacing.XXL;

  final String? imageUrl;
  final String? badge;
  final double width;
  final double height;

  const ImagePanel({
    required this.imageUrl,
    this.badge,
    this.width = DEFAULT_WIDTH,
    this.height = DEFAULT_HEIGHT,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colors.onBackground),
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: CachedNetworkImageProvider(imageUrl ?? ''),
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const DefaultImagePlaceholder(),
          ),
          if (badge != null)
            Positioned(
              left: context.dimensions.dimensionSm,
              bottom: context.dimensions.dimensionSm,
              child: BadgeLabel(label: badge!),
            ),
        ],
      ),
    );
  }
}

class DefaultImagePlaceholder extends StatelessWidget {
  const DefaultImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(image: AppImages.fallbackAvatarCat, fit: BoxFit.cover);
  }
}
