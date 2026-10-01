import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/ui/l10n/extension/l10n_extension.dart';
import '../../../../../../app/ui/navigation/app_navigation.dart';
import '../../../../../data/repositories/entities/cat.dart';

class CatsListWidget extends StatelessWidget {
  final List<Cat> cats;
  const CatsListWidget({required this.cats, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: cats.length,
      itemBuilder: (BuildContext context, int index) {
        final Cat cat = cats[index];
        return Padding(
          padding: EdgeInsets.all(context.dimensions.dimensionSm),
          child: InfoCard(
            imageUrl: cat.image?.url,
            title: cat.name,
            subtitle: cat.breedGroup,
            badge: cat.countryCode,
            details: [
              DetailData(
                label: context.l10n.catDetailLifeSpan,
                value: cat.lifeSpan,
              ),
              if (cat.origin != null)
                DetailData(
                  label: context.l10n.catDetailOriginCountry,
                  value: cat.origin!,
                ),
            ],
            onTap: () => AppNavigation.pushToCatDetail(context, cat.id),
          ),
        );
      },
      separatorBuilder: (_, _) => Padding(
        padding: EdgeInsetsGeometry.all(context.dimensions.dimensionSm),
        child: Divider(color: context.colors.borderFocus),
      ),
    );
  }
}
