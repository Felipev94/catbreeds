import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/home/view_model/cats_view_model.dart';
import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:catbreeds/cats/ui/home/view_model/state/cats_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'error/cats_error_widget.dart';
import 'loading/cats_skeleton_loader_widget.dart';
import 'success/cats_list_widget.dart';

class CatsView extends StatelessWidget {
  const CatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSignalSelector<CatsViewModel, CatsState, UiState<List<Cat>>>(
      selector: (state) => state.cats,
      builder: (BuildContext context, UiState<List<Cat>> value) {
        return value.when<Widget>(
          init: () => CatsSkeletonView(),
          loading: () => CatsSkeletonView(),
          success: (List<Cat> cats) => CatsListWidget(cats: cats),
          error: (String message, _) => CatsErrorWidget(
            message: message,
            onRetry: () => context.read<CatsViewModel>().add(FetchCats()),
          ),
        );
      },
    );
  }
}
