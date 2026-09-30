import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemoryCacheClient Test', () {
    late MemoryCacheClient cache;

    setUp(() {
      MemoryCacheClient.resetInstanceForTesting();
      cache = MemoryCacheClient();
    });

    tearDown(() {
      MemoryCacheClient.resetInstanceForTesting();
    });

    test('implements CacheClient interface', () {
      expect(cache, isA<CacheClient>());
    });

    test('returns same singleton instance across calls', () {
      final cache2 = MemoryCacheClient();
      expect(identical(cache, cache2), isTrue);
    });

    test('resetInstanceForTesting clears instance and internal store', () {
      cache.write(key: 'k1', value: 'v1');
      MemoryCacheClient.resetInstanceForTesting();

      final newCache = MemoryCacheClient();
      expect(identical(cache, newCache), isFalse);
      expect(newCache.read<String>(key: 'k1'), isNull);
    });

    test('write and read stores and retrieves typed value', () {
      cache.write<String>(key: 'name', value: 'Garfield');
      cache.write<int>(key: 'age', value: 5);

      expect(cache.read<String>(key: 'name'), equals('Garfield'));
      expect(cache.read<int>(key: 'age'), equals(5));
    });

    test('read returns null when key does not exist', () {
      expect(cache.read<String>(key: 'non_existing'), isNull);
    });

    test('readAll returns all stored items cast to requested type', () {
      cache.write<String>(key: 'cat1', value: 'Persian');
      cache.write<String>(key: 'cat2', value: 'Siamese');
      cache.write<String>(key: 'cat3', value: 'Bengal');

      final result = cache.readAll<String>();

      expect(result, hasLength(3));
      expect(result, containsAll(['Persian', 'Siamese', 'Bengal']));
    });

    test('readAll returns empty list when cache is empty', () {
      expect(cache.readAll<String>(), isEmpty);
    });

    test('delete removes existing key', () {
      cache.write<String>(key: 'temp', value: 'value');
      expect(cache.containsKey(key: 'temp'), isTrue);

      cache.delete(key: 'temp');

      expect(cache.containsKey(key: 'temp'), isFalse);
      expect(cache.read<String>(key: 'temp'), isNull);
    });

    test('clear removes all entries', () {
      cache.write(key: 'k1', value: 1);
      cache.write(key: 'k2', value: 2);
      expect(cache.readAll<int>(), hasLength(2));

      cache.clear();

      expect(cache.readAll<int>(), isEmpty);
      expect(cache.containsKey(key: 'k1'), isFalse);
      expect(cache.containsKey(key: 'k2'), isFalse);
    });

    test('containsKey returns true if key exists, false otherwise', () {
      expect(cache.containsKey(key: 'exists'), isFalse);

      cache.write<bool>(key: 'exists', value: true);

      expect(cache.containsKey(key: 'exists'), isTrue);
    });
  });
}
