import 'dart:async';

import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local_impl.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote_impl.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository_impl.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../di_module.dart';

final class CatsModule implements DiModule {
  const CatsModule();

  @override
  FutureOr<void> register(GetIt sl) {
    sl.registerLazySingleton<CatsApiServices>(
      () => CatsApiServices(sl<Dio>()),
    );

    sl.registerLazySingleton<CatsDatasourceLocal>(
      () => CatsDatasourceLocalImpl(sl<CacheClient>()),
    );

    sl.registerLazySingleton<CatsDatasourceRemote>(
      () => CatsDatasourceRemoteImpl(sl<CatsApiServices>()),
    );

    sl.registerLazySingleton<CatsRepository>(
      () => CatsRepositoryImpl(
        sl<CatsDatasourceLocal>(),
        sl<CatsDatasourceRemote>(),
      ),
    );
  }
}
