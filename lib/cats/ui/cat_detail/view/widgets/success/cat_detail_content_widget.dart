import 'package:catbreeds/app/ui/l10n/extension/l10n_extension.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatDetailContentWidget extends StatelessWidget {
  final Cat cat;

  const CatDetailContentWidget({required this.cat, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> temperaments = cat.temperament
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    return Padding(
      padding: EdgeInsets.all(context.dimensions.dimensionMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat.name,
                      style: context.typography.headlineSmall?.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (cat.origin != null) ...[
                      SizedBox(height: context.dimensions.dimensionXxs),
                      Text(
                        cat.origin!,
                        style: context.typography.bodyMedium?.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (cat.countryCode != null) BadgeLabel(label: cat.countryCode!),
            ],
          ),
          if (temperaments.isNotEmpty) ...[
            SizedBox(height: context.dimensions.dimensionMd),
            Text(
              context.l10n.catDetailTemperament,
              style: context.typography.titleSmall?.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.dimensions.dimensionXs),
            Wrap(
              spacing: context.dimensions.dimensionXs,
              runSpacing: context.dimensions.dimensionXs,
              children: [
                for (final tag in temperaments) BadgeLabel(label: tag),
              ],
            ),
          ],
          SizedBox(height: context.dimensions.dimensionMd),
          InfoSection(
            title: context.l10n.catDetailDescription,
            child: Text(
              cat.description,
              style: context.typography.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: context.dimensions.dimensionMd),
          InfoSection(
            title: context.l10n.catDetailPhysicalCharacteristics,
            child: Column(
              children: [
                DetailRow(
                  detail: DetailData(
                    label: context.l10n.catDetailWeight,
                    value: context.l10n.catDetailWeightValue(
                      cat.weight.metric,
                      cat.weight.imperial,
                    ),
                  ),
                ),
                SizedBox(height: context.dimensions.dimensionXs),
                DetailRow(
                  detail: DetailData(
                    label: context.l10n.catDetailHeight,
                    value: context.l10n.catDetailHeightValue(
                      cat.height.metric,
                      cat.height.imperial,
                    ),
                  ),
                ),
                SizedBox(height: context.dimensions.dimensionXs),
                DetailRow(
                  detail: DetailData(
                    label: context.l10n.catDetailLifeSpan,
                    value: context.l10n.catDetailLifeSpanYears(cat.lifeSpan),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.dimensions.dimensionMd),
          InfoSection(
            title: context.l10n.catDetailGeneralInfo,
            child: Column(
              children: [
                if (cat.origin != null) ...[
                  DetailRow(
                    detail: DetailData(
                      label: context.l10n.catDetailOriginCountry,
                      value: cat.origin!,
                    ),
                  ),
                  SizedBox(height: context.dimensions.dimensionXs),
                ],
                if (cat.countryCodes != null) ...[
                  DetailRow(
                    detail: DetailData(
                      label: context.l10n.catDetailCountryCodes,
                      value: cat.countryCodes!,
                    ),
                  ),
                  SizedBox(height: context.dimensions.dimensionXs),
                ],
                if (cat.breedGroup != null) ...[
                  DetailRow(
                    detail: DetailData(
                      label: context.l10n.catDetailBreedGroup,
                      value: cat.breedGroup!,
                    ),
                  ),
                  SizedBox(height: context.dimensions.dimensionXs),
                ],
                if (cat.bredFor != null) ...[
                  DetailRow(
                    detail: DetailData(
                      label: context.l10n.catDetailBredFor,
                      value: cat.bredFor!,
                    ),
                  ),
                  SizedBox(height: context.dimensions.dimensionXs),
                ],
                if (cat.perfectFor != null)
                  DetailRow(
                    detail: DetailData(
                      label: context.l10n.catDetailPerfectFor,
                      value: cat.perfectFor!,
                    ),
                  ),
              ],
            ),
          ),
          if (cat.history != null && cat.history!.isNotEmpty) ...[
            SizedBox(height: context.dimensions.dimensionMd),
            InfoSection(
              title: context.l10n.catDetailHistory,
              child: Text(
                cat.history!,
                style: context.typography.bodyMedium?.copyWith(
                  color: context.colors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
          SizedBox(height: context.dimensions.dimensionLg),
        ],
      ),
    );
  }
}
