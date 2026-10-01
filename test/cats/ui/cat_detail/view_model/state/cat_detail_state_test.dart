import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/state/cat_detail_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatDetailState Test', () {
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
      const state = CatDetailState();

      expect(state.cat, isA<UiInit<Cat>>());
    });

    test('constructor sets custom cat UiState', () {
      const state = CatDetailState(cat: UiState.success(sampleCat));

      expect(state.cat, isA<UiSuccess<Cat>>());
      final success = state.cat as UiSuccess<Cat>;
      expect(success.data, equals(sampleCat));
    });

    test('copyWith creates new instance with updated cat', () {
      const initialState = CatDetailState();
      expect(initialState.cat, isA<UiInit<Cat>>());

      final updatedState = initialState.copyWith(
        cat: const UiState.success(sampleCat),
      );

      expect(updatedState.cat, isA<UiSuccess<Cat>>());
      final success = updatedState.cat as UiSuccess<Cat>;
      expect(success.data, equals(sampleCat));
    });

    test('copyWith preserves current cat when cat argument is null', () {
      const initialState = CatDetailState(cat: UiState.success(sampleCat));

      final copiedState = initialState.copyWith();

      expect(copiedState.cat, isA<UiSuccess<Cat>>());
      final success = copiedState.cat as UiSuccess<Cat>;
      expect(success.data, equals(sampleCat));
    });
  });
}
