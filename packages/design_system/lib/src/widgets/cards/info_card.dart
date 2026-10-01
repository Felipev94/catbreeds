import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

typedef InfoCardMetric = MetricData;

typedef InfoCardDetail = DetailData;

class InfoCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String? subtitle;
  final String? badge;
  final List<MetricData> metrics;
  final List<DetailData> details;
  final VoidCallback? onTap;

  const InfoCard({
    required this.title,
    this.imageUrl,
    this.subtitle,
    this.badge,
    this.metrics = const [],
    this.details = const [],
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: AppRadius.RADIUS_LG,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.RADIUS_LG,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.RADIUS_LG,
            boxShadow: context.isDarkMode
                ? AppShadows.DARK_LEVEL_1
                : AppShadows.LIGHT_LEVEL_2,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: .stretch,
              children: [
                ImagePanel(imageUrl: imageUrl, badge: badge),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(context.dimensions.dimensionMd),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Row(
                          crossAxisAlignment: .start,
                          children: [
                            Expanded(
                              child: CardTitleSection(
                                title: title,
                                subtitle: subtitle,
                              ),
                            ),
                            if (onTap != null) ...[
                              SizedBox(width: context.dimensions.dimensionXs),
                              const ChevronBadge(),
                            ],
                          ],
                        ),

                        if (metrics.isNotEmpty || details.isNotEmpty)
                          SizedBox(height: context.dimensions.dimensionSm),

                        if (metrics.isNotEmpty)
                          ...metrics.map(
                            (m) => Padding(
                              padding: EdgeInsets.only(
                                bottom: context.dimensions.dimensionXs,
                              ),
                              child: MetricRow(metric: m),
                            ),
                          ),

                        if (metrics.isNotEmpty && details.isNotEmpty)
                          SizedBox(height: context.dimensions.dimensionXs),

                        if (details.isNotEmpty)
                          ...details.map(
                            (d) => Padding(
                              padding: EdgeInsets.only(
                                bottom: context.dimensions.dimensionXxs,
                              ),
                              child: DetailRow(detail: d),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
