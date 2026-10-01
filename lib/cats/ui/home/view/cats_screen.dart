import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/app/bootstrap/di/service_locator.dart';
import 'package:catbreeds/app/ui/l10n/extension/l10n_extension.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/ui/home/view/widgets/cats_view.dart';
import 'package:catbreeds/cats/ui/home/view_model/cats_view_model.dart';
import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocSignalProvider(
      providers: [
        BlocSignalProvider(
          create: (_) =>
              CatsViewModel(ServiceLocator.instance<CatsRepository>())
                ..add(FetchCats()),
        ),
      ],
      child: ScaffoldTemplate(
        expandedHeader: Align(
          alignment: .topCenter,
          child: Text(
            context.l10n.appName,
            style: context.typography.titleLarge,
          ),
        ),
        shrinkingHeader: SearchInput(
          hint: context.l10n.catsSearchHint,
          readOnly: true,
          onTap: () {},
        ),
        content: [const CatsView()],
      ),
    );
  }
}
