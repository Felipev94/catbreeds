import 'package:bloc_signals_test/bloc_signals_test.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/cat_detail_view_model.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/state/cat_detail_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../home/view_model/cats_view_model_test.mocks.dart';

void main() {
  late MockCatsRepository mockCatsRepository;

  const sampleCat = Cat(
    id: 'abys',
    name: 'Abyssinian',
    speciesId: '1',
    lifeSpan: '14-17',
    temperament: 'Active, Energetic',
    description: 'The Abyssinian is easy to care for.',
    weight: CatWeight(imperial: '7 - 10', metric: '3 - 5'),
    height: CatHeight(imperial: '8 - 10', metric: '20 - 25'),
  );

  setUpAll(() {
    provideDummy<Either<Failure, Cat>>(const Left(UnknownFailure('')));
  });

  setUp(() {
    mockCatsRepository = MockCatsRepository();
  });

  group('CatDetailViewModel', () {
    test('initial state has cat as UiInit', () {
      final viewModel = CatDetailViewModel(mockCatsRepository);

      expect(viewModel.state.value, isA<CatDetailState>());
      expect(viewModel.state.value.cat, isA<UiInit<Cat>>());
    });

    group('FetchCatDetail', () {
      blocSignalTest<CatDetailViewModel, CatDetailState>(
        'emits [UiLoading, UiSuccess] when repository returns cat successfully',
        setUp: () {
          when(mockCatsRepository.getCatById('abys')).thenAnswer(
            (_) async => const Right(sampleCat),
          );
        },
        build: () => CatDetailViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCatDetail('abys')),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiLoading<Cat>>(),
          ),
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiSuccess<Cat>>().having(
              (u) => u.data,
              'data',
              equals(sampleCat),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.getCatById('abys')).called(1);
        },
      );

      blocSignalTest<CatDetailViewModel, CatDetailState>(
        'emits [UiLoading, UiError] when repository returns ServerFailure',
        setUp: () {
          when(mockCatsRepository.getCatById('abys')).thenAnswer(
            (_) async => const Left(ServerFailure('Cat not found', statusCode: 404)),
          );
        },
        build: () => CatDetailViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCatDetail('abys')),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiLoading<Cat>>(),
          ),
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiError<Cat>>().having(
              (u) => u.message,
              'message',
              equals('Cat not found'),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.getCatById('abys')).called(1);
        },
      );

      blocSignalTest<CatDetailViewModel, CatDetailState>(
        'emits [UiLoading, UiError] when repository returns NetworkFailure',
        setUp: () {
          when(mockCatsRepository.getCatById('abys')).thenAnswer(
            (_) async => const Left(NetworkFailure('No connection')),
          );
        },
        build: () => CatDetailViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(FetchCatDetail('abys')),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiLoading<Cat>>(),
          ),
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiError<Cat>>().having(
              (u) => u.message,
              'message',
              equals('No connection'),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.getCatById('abys')).called(1);
        },
      );
    });

    group('RetryCatDetail', () {
      blocSignalTest<CatDetailViewModel, CatDetailState>(
        'triggers fetch again and emits [UiLoading, UiSuccess] on retry',
        setUp: () {
          when(mockCatsRepository.getCatById('abys')).thenAnswer(
            (_) async => const Right(sampleCat),
          );
        },
        build: () => CatDetailViewModel(mockCatsRepository),
        act: (viewModel) => viewModel.add(RetryCatDetail('abys')),
        wait: const Duration(milliseconds: 50),
        expect: () => [
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiLoading<Cat>>(),
          ),
          isA<CatDetailState>().having(
            (s) => s.cat,
            'cat',
            isA<UiSuccess<Cat>>().having(
              (u) => u.data,
              'data',
              equals(sampleCat),
            ),
          ),
        ],
        verify: (_) {
          verify(mockCatsRepository.getCatById('abys')).called(1);
        },
      );
    });
  });
}
