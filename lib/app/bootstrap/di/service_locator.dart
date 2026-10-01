import 'package:get_it/get_it.dart';

import 'di_module.dart';
import 'modules/cats_module.dart';
import 'modules/core_module.dart';
import 'modules/network_module.dart';

abstract final class ServiceLocator {
  static final GetIt instance = GetIt.instance;

  static List<DiModule> get defaultModules => const [
        CoreModule(),
        NetworkModule(),
        CatsModule(),
      ];

  static Future<void> init({List<DiModule>? modules}) async {
    final List<DiModule> activeModules = modules ?? defaultModules;
    for (final DiModule module in activeModules) {
      await module.register(instance);
    }
  }

  static Future<void> reset() async {
    await instance.reset();
  }
}
