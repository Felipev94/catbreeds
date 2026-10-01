import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/app/bootstrap/di/service_locator.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/ui/cat_detail/view/widgets/cat_detail_view.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/cat_detail_view_model.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:flutter/material.dart';

class CatDetailScreen extends StatelessWidget {
  final String catId;
  const CatDetailScreen({required this.catId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSignalProvider(
      create: (_) => CatDetailViewModel(
        ServiceLocator.instance<CatsRepository>(),
      )..add(FetchCatDetail(catId)),
      child: CatDetailView(catId: catId),
    );
  }
}
