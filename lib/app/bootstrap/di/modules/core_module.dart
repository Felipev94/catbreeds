import 'dart:async';

import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../di_module.dart';

final class CoreModule implements DiModule {
  final CacheClient? customCacheClient;

  const CoreModule({this.customCacheClient});

  @override
  FutureOr<void> register(GetIt sl) {
    sl.registerLazySingleton<CacheClient>(
      () => customCacheClient ?? MemoryCacheClient(),
    );
  }
}
