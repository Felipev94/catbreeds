import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';
import 'package:retrofit/retrofit.dart';

import 'cats_api_services_test.mocks.dart';

@GenerateMocks([Dio, HttpClientAdapter])
void main() {
  late MockDio mockDio;
  late CatsApiServices catsApiServices;
  const baseUrl = 'https://api.thecatapi.com/v1';

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options).thenReturn(BaseOptions(baseUrl: baseUrl));
    catsApiServices = CatsApiServices(mockDio);
  });

  group('CatsApiServices with Mockito', () {
    test('getCats calls Dio.fetch with GET and /breeds, parsing response correctly', () async {
      final mockData = [
        {
          'id': 'abys',
          'name': 'Abyssinian',
          'species_id': '1',
          'life_span': '14-17',
          'temperament': 'Active, Energetic',
          'origin': 'Egypt',
          'country_codes': 'EG',
          'country_code': 'EG',
          'description': 'Medium-sized cat',
          'weight': {'imperial': '8-12', 'metric': '3.6-5.4'},
          'height': {'imperial': '10-12', 'metric': '25-30'},
          'image': {
            'id': 'KWdLHmOqc',
            'url': 'https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg',
            'width': 3114,
            'height': 2609,
          },
        },
      ];

      when(mockDio.fetch<List<dynamic>>(any)).thenAnswer((invocation) async {
        final requestOptions =
            invocation.positionalArguments.first as RequestOptions;
        return Response<List<dynamic>>(
          data: mockData,
          statusCode: 200,
          requestOptions: requestOptions,
        );
      });

      final HttpResponse<List<CatDto>> response = await catsApiServices
          .getCats();

      expect(response.response.statusCode, equals(200));
      expect(response.data, hasLength(1));

      final cat = response.data.first;
      expect(cat.id, equals('abys'));
      expect(cat.name, equals('Abyssinian'));
      expect(cat.speciesId, equals('1'));
      expect(cat.lifeSpan, equals('14-17'));
      expect(cat.temperament, equals('Active, Energetic'));
      expect(cat.origin, equals('Egypt'));
      expect(cat.description, equals('Medium-sized cat'));
      expect(cat.weight.imperial, equals('8-12'));
      expect(cat.weight.metric, equals('3.6-5.4'));
      expect(cat.height.imperial, equals('10-12'));
      expect(cat.height.metric, equals('25-30'));
      expect(cat.image?.id, equals('KWdLHmOqc'));
      expect(
        cat.image?.url,
        equals('https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg'),
      );

      verify(
        mockDio.fetch<List<dynamic>>(
          argThat(
            predicate<RequestOptions>(
              (options) => options.method == 'GET' && options.path == '/breeds',
            ),
          ),
        ),
      ).called(1);
    });

    test('getCats correctly parses multiple breeds from response', () async {
      final mockList = [
        {
          'id': 'abys',
          'name': 'Abyssinian',
          'species_id': '1',
          'life_span': '14-17',
          'temperament': 'Active, Energetic',
          'origin': 'Egypt',
          'description': 'Medium-sized cat',
          'weight': {'imperial': '8-12', 'metric': '3.6-5.4'},
          'height': {'imperial': '10-12', 'metric': '25-30'},
        },
        {
          'id': 'aege',
          'name': 'Aegean',
          'species_id': '1',
          'life_span': '9-12',
          'temperament': 'Affectionate, Social',
          'origin': 'Greece',
          'description': 'Natural breed',
          'weight': {'imperial': '9-12', 'metric': '4-5.4'},
          'height': {'imperial': '9-11', 'metric': '23-28'},
        },
      ];

      when(mockDio.fetch<List<dynamic>>(any)).thenAnswer((invocation) async {
        final requestOptions =
            invocation.positionalArguments.first as RequestOptions;
        return Response<List<dynamic>>(
          data: mockList,
          statusCode: 200,
          requestOptions: requestOptions,
        );
      });

      final response = await catsApiServices.getCats();

      expect(response.response.statusCode, equals(200));
      expect(response.data, hasLength(2));
      expect(response.data.first.id, equals('abys'));
      expect(response.data.last.id, equals('aege'));

      verify(mockDio.fetch<List<dynamic>>(any)).called(1);
    });

    test('getCats resolves with custom baseUrl', () async {
      const customBaseUrl = 'https://custom-api.example.com/api';
      final customService = CatsApiServices(mockDio, baseUrl: customBaseUrl);

      when(mockDio.fetch<List<dynamic>>(any)).thenAnswer((invocation) async {
        final requestOptions =
            invocation.positionalArguments.first as RequestOptions;
        return Response<List<dynamic>>(
          data: [],
          statusCode: 200,
          requestOptions: requestOptions,
        );
      });

      await customService.getCats();

      verify(
        mockDio.fetch<List<dynamic>>(
          argThat(
            predicate<RequestOptions>(
              (options) =>
                  options.baseUrl == customBaseUrl && options.path == '/breeds',
            ),
          ),
        ),
      ).called(1);
    });

    test('getCats propagates DioException when Dio.fetch fails', () async {
      final requestOptions = RequestOptions(path: '/breeds');
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(
          statusCode: 500,
          statusMessage: 'Internal Server Error',
          requestOptions: requestOptions,
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockDio.fetch<List<dynamic>>(any)).thenThrow(dioException);

      expect(
        () => catsApiServices.getCats(),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            equals(500),
          ),
        ),
      );

      verify(mockDio.fetch<List<dynamic>>(any)).called(1);
    });

    test(
      'getCats throws TypeError and logs when parsing invalid schema',
      () async {
        when(mockDio.fetch<List<dynamic>>(any)).thenAnswer((invocation) async {
          final requestOptions =
              invocation.positionalArguments.first as RequestOptions;
          return Response<List<dynamic>>(
            data: [
              {'invalid_payload': 123},
            ],
            statusCode: 200,
            requestOptions: requestOptions,
          );
        });

        expect(() => catsApiServices.getCats(), throwsA(isA<TypeError>()));

        verify(mockDio.fetch<List<dynamic>>(any)).called(1);
      },
    );
  });
}
