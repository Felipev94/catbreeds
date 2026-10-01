import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local_impl.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote_impl.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository_impl.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/cat_detail_view_model.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:core/core.dart' hide State;
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatDetailScreen extends StatefulWidget {
  final String catId;
  const CatDetailScreen({required this.catId, super.key});

  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

class _CatDetailScreenState extends State<CatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocSignalProvider(
      create: (_) => CatDetailViewModel(
        CatsRepositoryImpl(
          CatsDatasourceLocalImpl(MemoryCacheClient()),
          CatsDatasourceRemoteImpl(
            CatsApiServices(
              DioFactory.create(
                options: NetworkOptions(
                  baseUrl: const String.fromEnvironment('API_URL'),
                  headers: {
                    'x-api-key': const String.fromEnvironment('API_KEY'),
                  },
                ),
                globalInterceptors: {},
              ),
            ),
          ),
        ),
      )..add(FetchCatDetail(widget.catId)),
      child: ScaffoldTemplate(content: []),
    );
  }
}
