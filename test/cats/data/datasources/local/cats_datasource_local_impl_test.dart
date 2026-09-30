import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cats_datasource_local_impl_test.mocks.dart';

@GenerateMocks([CacheClient])
void main() {
  late MockCacheClient mockCache;
  late CatsDatasourceLocalImpl datasource;

  const sampleCat1 = CatDto(
    id: 'abys',
    name: 'Abyssinian',
    speciesId: '1',
    lifeSpan: '14-17',
    temperament: 'Active',
    description: 'Medium cat',
    weight: CatWeightDto(imperial: '8-12', metric: '3.6-5.4'),
    height: CatHeightDto(imperial: '10-12', metric: '25-30'),
  );

  const sampleCat2 = CatDto(
    id: 'beng',
    name: 'Bengal',
    speciesId: '1',
    lifeSpan: '12-16',
    temperament: 'Alert, Agile',
    description: 'Wild cat build',
    weight: CatWeightDto(imperial: '8-15', metric: '3.6-6.8'),
    height: CatHeightDto(imperial: '11-14', metric: '28-35'),
  );

  setUp(() {
    mockCache = MockCacheClient();
    datasource = CatsDatasourceLocalImpl(mockCache);
  });

  group('CatsDatasourceLocalImpl', () {
    test('fetchCats delegates to CacheClient.readAll and returns cats list', () {
      when(mockCache.readAll<CatDto>()).thenReturn([sampleCat1, sampleCat2]);

      final result = datasource.fetchCats();

      expect(result, hasLength(2));
      expect(result.first.id, equals('abys'));
      expect(result.last.id, equals('beng'));
      verify(mockCache.readAll<CatDto>()).called(1);
    });

    test('getCatById delegates to CacheClient.read with correct key', () {
      when(mockCache.read<CatDto>(key: 'abys')).thenReturn(sampleCat1);

      final result = datasource.getCatById('abys');

      expect(result, isNotNull);
      expect(result?.id, equals('abys'));
      expect(result?.name, equals('Abyssinian'));
      verify(mockCache.read<CatDto>(key: 'abys')).called(1);
    });

    test('getCatById returns null when cat does not exist in cache', () {
      when(mockCache.read<CatDto>(key: 'unknown')).thenReturn(null);

      final result = datasource.getCatById('unknown');

      expect(result, isNull);
      verify(mockCache.read<CatDto>(key: 'unknown')).called(1);
    });

    test('saveCats iterates and writes each cat using cat.id as key', () {
      datasource.saveCats([sampleCat1, sampleCat2]);

      verify(mockCache.write<CatDto>(key: 'abys', value: sampleCat1)).called(1);
      verify(mockCache.write<CatDto>(key: 'beng', value: sampleCat2)).called(1);
      verifyNoMoreInteractions(mockCache);
    });

    test('saveCat writes a single cat using cat.id as key', () {
      datasource.saveCat(sampleCat1);

      verify(mockCache.write<CatDto>(key: 'abys', value: sampleCat1)).called(1);
      verifyNoMoreInteractions(mockCache);
    });
  });
}
