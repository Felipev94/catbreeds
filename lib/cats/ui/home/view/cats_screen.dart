import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local_impl.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote_impl.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository_impl.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:catbreeds/cats/ui/home/view/widgets/cats_view.dart';
import 'package:catbreeds/cats/ui/home/view_model/cats_view_model.dart';
import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:core/core.dart' hide State;
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
          create: (_) => CatsViewModel(
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
          )..add(FetchCats()),
        ),
      ],
      child: Scaffold(body: CatsView()),
    );
  }
}
