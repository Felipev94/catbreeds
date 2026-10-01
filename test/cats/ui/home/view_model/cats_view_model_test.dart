import 'package:bloc_signals_test/bloc_signals_test.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/home/view_model/cats_view_model.dart';
import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:catbreeds/cats/ui/home/view_model/state/cats_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cats_view_model_test.mocks.dart';

@GenerateMocks([CatsRepository])
void main() {
  late MockCatsRepository mockCatsRepository;

  const sampleCat1 = Cat(
    id: 'abys',
    name: 'Abyssinian',
    speciesId: '1',
    lifeSpan: '14-17',
    temperament: 'Active, Energetic',
    description: 'The Abyssinian is easy to care for.',
    weight: CatWeight(imperial: '7 - 10', metric: '3 - 5'),
    height: CatHeight(imperial: '8 - 10', metric: '20 - 25'),
  );

  const sampleCat2 = Cat(
    id: 'beng',
    name: 'Bengal',
    speciesId: '1',
    lifeSpan: '12-15',
    temperament: 'Alert, Agile',
    description: 'Bengals are a lot of fun to live with.',
    weight: CatWeight(imperial: '6 - 12', metric: '3 - 7'),
    height: CatHeight(imperial: '8 - 10', metric: '20 - 25'),
  );

  setUpAll(() {
    provideDummy<Either<Failure, List<Cat>>>(const Right([]));
    provideDummy<Either<Failure, Cat>>(const Left(UnknownFailure('')));
  });

  setUp(() {
    mockCatsRepository = MockCatsRepository();
  });

  group('CatsViewModel', () {
    test('initial state has cats as UiInit', () {
      final viewModel = CatsViewModel(mockCatsRepository);

      expect(viewModel.state.value, isA<CatsState>());
      expect(viewModel.state.value.cats, isA<UiInit<List<Cat>>>());
    });

    group('FetchCats', () {
      blocSignalTest<CatsViewModel, CatsState>(
        'emits [UiLoading, UiSuccess] when repository returns cats successfully',
        setUp: () {
          when(mockCatsRepository.fetchCats()).thenAnswer(
            (_) async => const Right([sampleCat1, sampleCat2]),
          );
        },
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCats()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiLoading<List<Cat>>>(),
          ),
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiSuccess<List<Cat>>>().having(
              (u) => u.data,
              'data',
              equals([sampleCat1, sampleCat2]),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.fetchCats()).called(1);
        },
      );

      blocSignalTest<CatsViewModel, CatsState>(
        'emits [UiLoading, UiSuccess] with empty list when repository returns empty cats list',
        setUp: () {
          when(mockCatsRepository.fetchCats()).thenAnswer(
            (_) async => const Right([]),
          );
        },
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCats()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiLoading<List<Cat>>>(),
          ),
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiSuccess<List<Cat>>>().having(
              (u) => u.data,
              'data',
              isEmpty,
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.fetchCats()).called(1);
        },
      );

      blocSignalTest<CatsViewModel, CatsState>(
        'emits [UiLoading, UiError] when repository returns ServerFailure',
        setUp: () {
          when(mockCatsRepository.fetchCats()).thenAnswer(
            (_) async => const Left(ServerFailure('Internal Server Error', statusCode: 500)),
          );
        },
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCats()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiLoading<List<Cat>>>(),
          ),
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiError<List<Cat>>>().having(
              (u) => u.message,
              'message',
              equals('Internal Server Error'),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.fetchCats()).called(1);
        },
      );

      blocSignalTest<CatsViewModel, CatsState>(
        'emits [UiLoading, UiError] when repository returns NetworkFailure',
        setUp: () {
          when(mockCatsRepository.fetchCats()).thenAnswer(
            (_) async => const Left(NetworkFailure('No Internet Connection')),
          );
        },
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCats()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiLoading<List<Cat>>>(),
          ),
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiError<List<Cat>>>().having(
              (u) => u.message,
              'message',
              equals('No Internet Connection'),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.fetchCats()).called(1);
        },
      );

      blocSignalTest<CatsViewModel, CatsState>(
        'emits [UiLoading, UiError] when repository returns UnknownFailure',
        setUp: () {
          when(mockCatsRepository.fetchCats()).thenAnswer(
            (_) async => const Left(UnknownFailure('Something went wrong')),
          );
        },
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCats()),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiLoading<List<Cat>>>(),
          ),
          isA<CatsState>().having(
            (s) => s.cats,
            'cats',
            isA<UiError<List<Cat>>>().having(
              (u) => u.message,
              'message',
              equals('Something went wrong'),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.fetchCats()).called(1);
        },
      );
    });

    group('SearchCats', () {
      blocSignalTest<CatsViewModel, CatsState>(
        'does not emit any new states when SearchCats is triggered',
        build: () => CatsViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(SearchCats()),
        expect: () => <CatsState>[],
        verify: (_) {
          verifyZeroInteractions(mockCatsRepository);
        },
      );
    });
  });
}
