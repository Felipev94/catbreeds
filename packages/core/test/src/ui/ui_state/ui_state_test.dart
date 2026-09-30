import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UiState Test', () {
    test('UiState.init creates UiInit instance', () {
      const state = UiState<String>.init();

      expect(state, isA<UiInit<String>>());
      final result = state.when(
        init: () => 'init_called',
        loading: () => 'loading_called',
        success: (_) => 'success_called',
        error: (_, _) => 'error_called',
      );
      expect(result, equals('init_called'));
    });

    test('UiState.loading creates UiLoading instance', () {
      const state = UiState<int>.loading();

      expect(state, isA<UiLoading<int>>());
      final result = state.when(
        init: () => 'init_called',
        loading: () => 'loading_called',
        success: (_) => 'success_called',
        error: (_, _) => 'error_called',
      );
      expect(result, equals('loading_called'));
    });

    test('UiState.success creates UiSuccess instance with data', () {
      const state = UiState<String>.success('hello');

      expect(state, isA<UiSuccess<String>>());
      final successState = state as UiSuccess<String>;
      expect(successState.data, equals('hello'));

      final result = state.when(
        init: () => 'init_called',
        loading: () => 'loading_called',
        success: (data) => 'success with $data',
        error: (_, _) => 'error_called',
      );
      expect(result, equals('success with hello'));
    });

    test(
      'UiState.error creates UiError instance with message and optional error',
      () {
        final customError = Exception('Custom exception');
        final state = UiState<double>.error(
          'Failed to load',
          error: customError,
        );

        expect(state, isA<UiError<double>>());
        final errorState = state as UiError<double>;
        expect(errorState.message, equals('Failed to load'));
        expect(errorState.error, equals(customError));

        final result = state.when(
          init: () => 'init_called',
          loading: () => 'loading_called',
          success: (_) => 'success_called',
          error: (msg, err) => '$msg: $err',
        );
        expect(result, equals('Failed to load: Exception: Custom exception'));
      },
    );

    test('UiState.error works without optional error parameter', () {
      const state = UiState<String>.error('Simple error');

      expect(state, isA<UiError<String>>());
      final errorState = state as UiError<String>;
      expect(errorState.message, equals('Simple error'));
      expect(errorState.error, isNull);

      final result = state.when(
        init: () => 'init_called',
        loading: () => 'loading_called',
        success: (_) => 'success_called',
        error: (msg, err) => '$msg | err:$err',
      );
      expect(result, equals('Simple error | err:null'));
    });
  });
}
