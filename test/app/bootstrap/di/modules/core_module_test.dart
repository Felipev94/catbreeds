import 'package:catbreeds/app/bootstrap/di/modules/core_module.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  late GetIt sl;

  setUp(() async {
    sl = GetIt.asNewInstance();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('CoreModule Test', () {
    test('registers default MemoryCacheClient as CacheClient', () async {
      const module = CoreModule();
      await module.register(sl);

      expect(sl.isRegistered<CacheClient>(), isTrue);
      expect(sl<CacheClient>(), isA<MemoryCacheClient>());
    });

    test('registers custom CacheClient if provided', () async {
      final customCache = MemoryCacheClient();
      final module = CoreModule(customCacheClient: customCache);
      await module.register(sl);

      expect(sl.isRegistered<CacheClient>(), isTrue);
      expect(sl<CacheClient>(), same(customCache));
    });
  });
}
