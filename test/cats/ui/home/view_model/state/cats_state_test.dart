import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/home/view_model/state/cats_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatsState Test', () {
    const sampleCat = Cat(
      id: 'abys',
      name: 'Abyssinian',
      speciesId: '1',
      lifeSpan: '14-17',
      temperament: 'Active',
      description: 'Native to parts of Southeast Asia.',
      weight: CatWeight(imperial: '7 - 10', metric: '3 - 5'),
      height: CatHeight(imperial: '8 - 10', metric: '20 - 25'),
    );

    test('default constructor initializes with UiInit', () {
      const state = CatsState();

      expect(state.cats, isA<UiInit<List<Cat>>>());
    });

    test('constructor sets custom cats UiState', () {
      const state = CatsState(cats: UiState.success([sampleCat]));

      expect(state.cats, isA<UiSuccess<List<Cat>>>());
      final success = state.cats as UiSuccess<List<Cat>>;
      expect(success.data, equals([sampleCat]));
    });

    test('copyWith creates new instance with updated cats', () {
      const initialState = CatsState();
      expect(initialState.cats, isA<UiInit<List<Cat>>>());

      final updatedState = initialState.copyWith(
        cats: const UiState.success([sampleCat]),
      );

      expect(updatedState.cats, isA<UiSuccess<List<Cat>>>());
      final success = updatedState.cats as UiSuccess<List<Cat>>;
      expect(success.data, equals([sampleCat]));
    });

    test('copyWith preserves current cats when cats argument is null', () {
      const initialState = CatsState(cats: UiState.success([sampleCat]));

      final copiedState = initialState.copyWith();

      expect(copiedState.cats, isA<UiSuccess<List<Cat>>>());
      final success = copiedState.cats as UiSuccess<List<Cat>>;
      expect(success.data, equals([sampleCat]));
    });
  });
}
