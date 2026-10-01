import 'dart:async';

import 'package:catbreeds/app/bootstrap/di/di_module.dart';
import 'package:catbreeds/app/bootstrap/di/service_locator.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class _FakeTestModule implements DiModule {
  final String value;
  const _FakeTestModule(this.value);

  @override
  FutureOr<void> register(GetIt sl) {
    sl.registerSingleton<String>(value);
  }
}

void main() {
  tearDown(() async {
    await ServiceLocator.reset();
  });

  group('ServiceLocator Test', () {
    test('init with default modules registers core, network and cats dependencies', () async {
      await ServiceLocator.init();

      expect(ServiceLocator.instance.isRegistered<CacheClient>(), isTrue);
      expect(ServiceLocator.instance.isRegistered<Dio>(), isTrue);
      expect(ServiceLocator.instance.isRegistered<CatsRepository>(), isTrue);
    });

    test('init with custom modules registers only provided modules', () async {
      await ServiceLocator.init(modules: const [_FakeTestModule('hello')]);

      expect(ServiceLocator.instance.isRegistered<String>(), isTrue);
      expect(ServiceLocator.instance<String>(), equals('hello'));
      expect(ServiceLocator.instance.isRegistered<Dio>(), isFalse);
    });

    test('reset clears all registered dependencies', () async {
      await ServiceLocator.init(modules: const [_FakeTestModule('hello')]);
      expect(ServiceLocator.instance.isRegistered<String>(), isTrue);

      await ServiceLocator.reset();

      expect(ServiceLocator.instance.isRegistered<String>(), isFalse);
    });
  });
}
