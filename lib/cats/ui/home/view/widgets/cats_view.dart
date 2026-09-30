import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/home/view_model/cats_view_model.dart';
import 'package:catbreeds/cats/ui/home/view_model/state/cats_state.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatsView extends StatelessWidget {
  const CatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSignalSelector<CatsViewModel, CatsState, UiState<List<Cat>>>(
      selector: (state) => state.cats,
      builder: (BuildContext context, UiState<List<Cat>> value) {
        return value.when<Widget>(
          init: () => Container(),
          loading: () => Container(),
          success: (List<Cat> cats) => Container(color: context.colors.success),
          error: (String message, _) => Container(color: context.colors.error),
        );
      },
    );
  }
}
