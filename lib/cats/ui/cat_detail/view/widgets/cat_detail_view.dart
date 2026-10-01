import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/cat_detail/view/widgets/error/cat_detail_error_widget.dart';
import 'package:catbreeds/cats/ui/cat_detail/view/widgets/loading/cat_detail_skeleton_widget.dart';
import 'package:catbreeds/cats/ui/cat_detail/view/widgets/success/cat_detail_content_widget.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/cat_detail_view_model.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/state/cat_detail_state.dart';
import 'package:core/core.dart' hide State;
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatDetailView extends StatelessWidget {
  final String catId;
  const CatDetailView({required this.catId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSignalSelector<CatDetailViewModel, CatDetailState, UiState<Cat>>(
      selector: (state) => state.cat,
      builder: (context, value) {
        return value.when<Widget>(
          init: () => const DetailScaffoldTemplate(
            scrollable: false,
            content: CatDetailSkeletonWidget(),
          ),
          loading: () => const DetailScaffoldTemplate(
            scrollable: false,
            content: CatDetailSkeletonWidget(),
          ),
          error: (message, _) => DetailScaffoldTemplate(
            scrollable: false,
            content: CatDetailErrorWidget(
              message: message,
              onRetry: () =>
                  context.read<CatDetailViewModel>().add(RetryCatDetail(catId)),
            ),
          ),
          success: (Cat cat) => DetailScaffoldTemplate(
            title: cat.name,
            staticHeader: ImageBanner(
              imageUrl: cat.image?.url,
              badge: cat.countryCode,
            ),
            content: CatDetailContentWidget(cat: cat),
          ),
        );
      },
    );
  }
}
