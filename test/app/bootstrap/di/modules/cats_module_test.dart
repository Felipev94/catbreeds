import 'package:catbreeds/app/bootstrap/di/modules/cats_module.dart';
import 'package:catbreeds/app/bootstrap/di/modules/core_module.dart';
import 'package:catbreeds/app/bootstrap/di/modules/network_module.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  late GetIt sl;

  setUp(() async {
    sl = GetIt.asNewInstance();
    const CoreModule().register(sl);
    const NetworkModule().register(sl);
  });

  tearDown(() async {
    await sl.reset();
  });

  group('CatsModule Test', () {
    test('registers CatsApiServices, datasources, and CatsRepository', () async {
      const module = CatsModule();
      await module.register(sl);

      expect(sl.isRegistered<CatsApiServices>(), isTrue);
      expect(sl.isRegistered<CatsDatasourceLocal>(), isTrue);
      expect(sl.isRegistered<CatsDatasourceRemote>(), isTrue);
      expect(sl.isRegistered<CatsRepository>(), isTrue);

      expect(sl<CatsApiServices>(), isA<CatsApiServices>());
      expect(sl<CatsDatasourceLocal>(), isA<CatsDatasourceLocal>());
      expect(sl<CatsDatasourceRemote>(), isA<CatsDatasourceRemote>());
      expect(sl<CatsRepository>(), isA<CatsRepository>());
    });
  });
}
