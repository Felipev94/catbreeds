import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/datasources/remote/cats_datasource_remote_impl.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

import 'cats_datasource_remote_impl_test.mocks.dart';

@GenerateMocks([CatsApiServices])
void main() {
  late MockCatsApiServices mockApiServices;
  late CatsDatasourceRemoteImpl datasource;

  const sampleCat = CatDto(
    id: 'abys',
    name: 'Abyssinian',
    speciesId: '1',
    lifeSpan: '14-17',
    temperament: 'Active',
    description: 'Medium cat',
    weight: CatWeightDto(imperial: '8-12', metric: '3.6-5.4'),
    height: CatHeightDto(imperial: '10-12', metric: '25-30'),
  );

  final requestOptions = RequestOptions(path: '/breeds');

  setUp(() {
    mockApiServices = MockCatsApiServices();
    datasource = CatsDatasourceRemoteImpl(mockApiServices);
  });

  group('CatsDatasourceRemoteImpl', () {
    test('fetchCats returns ApiResponse.success when api returns 200', () async {
      final response = Response<dynamic>(
        requestOptions: requestOptions,
        statusCode: 200,
      );
      final httpResponse = HttpResponse<List<CatDto>>([sampleCat], response);

      when(mockApiServices.getCats()).thenAnswer((_) async => httpResponse);

      final result = await datasource.fetchCats();

      expect(result.isSuccess, isTrue);
      expect(result.data, hasLength(1));
      expect(result.data?.first.id, equals('abys'));
      expect(result.failure, isNull);
      verify(mockApiServices.getCats()).called(1);
    });

    test('fetchCats returns ApiResponse.error with ServerFailure when api throws 500 DioException', () async {
      final dioException = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: requestOptions,
          statusCode: 500,
          data: {'message': 'Server error'},
        ),
      );

      when(mockApiServices.getCats()).thenThrow(dioException);

      final result = await datasource.fetchCats();

      expect(result.isSuccess, isFalse);
      expect(result.data, isNull);
      expect(result.failure, isA<ServerFailure>());
      final failure = result.failure as ServerFailure;
      expect(failure.message, equals('Server error'));
      expect(failure.statusCode, equals(500));
      verify(mockApiServices.getCats()).called(1);
    });

    test('fetchCats returns ApiResponse.error with NetworkFailure when api times out', () async {
      final dioException = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiServices.getCats()).thenThrow(dioException);

      final result = await datasource.fetchCats();

      expect(result.isSuccess, isFalse);
      expect(result.data, isNull);
      expect(result.failure, isA<NetworkFailure>());
      expect(
        result.failure?.message,
        equals('No internet connection or timeout occurred'),
      );
      verify(mockApiServices.getCats()).called(1);
    });

    test('fetchCats returns ApiResponse.error with UnknownFailure on generic error', () async {
      when(mockApiServices.getCats()).thenThrow(Exception('Unexpected crash'));

      final result = await datasource.fetchCats();

      expect(result.isSuccess, isFalse);
      expect(result.data, isNull);
      expect(result.failure, isA<UnknownFailure>());
      expect(result.failure?.message, contains('Unexpected crash'));
      verify(mockApiServices.getCats()).called(1);
    });
  });
}
