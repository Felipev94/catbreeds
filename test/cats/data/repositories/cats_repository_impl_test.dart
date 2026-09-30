import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cats_repository_impl_test.mocks.dart';

@GenerateMocks([CatsDatasourceLocal, CatsDatasourceRemote])
void main() {
  late MockCatsDatasourceLocal mockLocalDatasource;
  late MockCatsDatasourceRemote mockRemoteDatasource;
  late CatsRepositoryImpl repository;

  const sampleCatDto1 = CatDto(
    id: 'abys',
    name: 'Abyssinian',
    speciesId: '1',
    lifeSpan: '14-17',
    temperament: 'Active',
    description: 'Medium cat',
    weight: CatWeightDto(imperial: '8-12', metric: '3.6-5.4'),
    height: CatHeightDto(imperial: '10-12', metric: '25-30'),
  );

  const sampleCatDto2 = CatDto(
    id: 'beng',
    name: 'Bengal',
    speciesId: '1',
    lifeSpan: '12-16',
    temperament: 'Agile',
    description: 'Wild cat build',
    weight: CatWeightDto(imperial: '8-15', metric: '3.6-6.8'),
    height: CatHeightDto(imperial: '11-14', metric: '28-35'),
  );

  setUp(() {
    mockLocalDatasource = MockCatsDatasourceLocal();
    mockRemoteDatasource = MockCatsDatasourceRemote();
    repository = CatsRepositoryImpl(mockLocalDatasource, mockRemoteDatasource);
  });

  group('CatsRepositoryImpl - fetchCats', () {
    test('returns cached cats as Right when local cache is not empty', () async {
      when(mockLocalDatasource.fetchCats()).thenReturn([sampleCatDto1, sampleCatDto2]);

      final result = await repository.fetchCats();

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (cats) {
          expect(cats, hasLength(2));
          expect(cats.first.id, equals('abys'));
          expect(cats.last.id, equals('beng'));
        },
      );

      verify(mockLocalDatasource.fetchCats()).called(1);
      verifyZeroInteractions(mockRemoteDatasource);
      verifyNever(mockLocalDatasource.saveCats(any));
    });

    test('fetches from remote, saves to cache and returns Right when cache is empty', () async {
      when(mockLocalDatasource.fetchCats()).thenReturn([]);
      when(mockRemoteDatasource.fetchCats()).thenAnswer(
        (_) async => ApiResponse.success([sampleCatDto1]),
      );

      final result = await repository.fetchCats();

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (cats) {
          expect(cats, hasLength(1));
          expect(cats.first.id, equals('abys'));
        },
      );

      verify(mockLocalDatasource.fetchCats()).called(1);
      verify(mockRemoteDatasource.fetchCats()).called(1);
      verify(mockLocalDatasource.saveCats([sampleCatDto1])).called(1);
    });

    test('returns Left when cache is empty and remote call fails', () async {
      when(mockLocalDatasource.fetchCats()).thenReturn([]);
      const networkFailure = NetworkFailure('No internet connection');
      when(mockRemoteDatasource.fetchCats()).thenAnswer(
        (_) async => ApiResponse.error(networkFailure),
      );

      final result = await repository.fetchCats();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, equals('No internet connection'));
        },
        (_) => fail('Expected Left but got Right'),
      );

      verify(mockLocalDatasource.fetchCats()).called(1);
      verify(mockRemoteDatasource.fetchCats()).called(1);
      verifyNever(mockLocalDatasource.saveCats(any));
    });
  });

  group('CatsRepositoryImpl - getCatById', () {
    test('returns cached cat as Right when cat is found in local cache', () async {
      when(mockLocalDatasource.getCatById('abys')).thenReturn(sampleCatDto1);

      final result = await repository.getCatById('abys');

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (cat) {
          expect(cat.id, equals('abys'));
          expect(cat.name, equals('Abyssinian'));
        },
      );

      verify(mockLocalDatasource.getCatById('abys')).called(1);
      verifyZeroInteractions(mockRemoteDatasource);
      verifyNever(mockLocalDatasource.saveCat(any));
    });

    test('fetches from remote, saves cat locally, and returns Right when cat found remotely', () async {
      when(mockLocalDatasource.getCatById('abys')).thenReturn(null);
      when(mockRemoteDatasource.fetchCats()).thenAnswer(
        (_) async => ApiResponse.success([sampleCatDto1, sampleCatDto2]),
      );

      final result = await repository.getCatById('abys');

      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (cat) {
          expect(cat.id, equals('abys'));
          expect(cat.name, equals('Abyssinian'));
        },
      );

      verify(mockLocalDatasource.getCatById('abys')).called(1);
      verify(mockRemoteDatasource.fetchCats()).called(1);
      verify(mockLocalDatasource.saveCat(sampleCatDto1)).called(1);
    });

    test('returns Left(ServerFailure 404) when cat is not found in remote response', () async {
      when(mockLocalDatasource.getCatById('unknown')).thenReturn(null);
      when(mockRemoteDatasource.fetchCats()).thenAnswer(
        (_) async => ApiResponse.success([sampleCatDto1]),
      );

      final result = await repository.getCatById('unknown');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          final serverFailure = failure as ServerFailure;
          expect(serverFailure.message, equals('Cat not found.'));
          expect(serverFailure.statusCode, equals(404));
        },
        (_) => fail('Expected Left but got Right'),
      );

      verify(mockLocalDatasource.getCatById('unknown')).called(1);
      verify(mockRemoteDatasource.fetchCats()).called(1);
      verifyNever(mockLocalDatasource.saveCat(any));
    });

    test('returns Left when cat is not in cache and remote fetch fails', () async {
      when(mockLocalDatasource.getCatById('abys')).thenReturn(null);
      const serverFailure = ServerFailure('Server unavailable', statusCode: 503);
      when(mockRemoteDatasource.fetchCats()).thenAnswer(
        (_) async => ApiResponse.error(serverFailure),
      );

      final result = await repository.getCatById('abys');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          final sf = failure as ServerFailure;
          expect(sf.message, equals('Server unavailable'));
          expect(sf.statusCode, equals(503));
        },
        (_) => fail('Expected Left but got Right'),
      );

      verify(mockLocalDatasource.getCatById('abys')).called(1);
      verify(mockRemoteDatasource.fetchCats()).called(1);
      verifyNever(mockLocalDatasource.saveCat(any));
    });
  });
}
