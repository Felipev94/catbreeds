sealed class UiState<T> {
  const UiState();

  const factory UiState.init() = UiInit<T>;
  const factory UiState.loading() = UiLoading<T>;
  const factory UiState.success(T data) = UiSuccess<T>;
  const factory UiState.error(String message, {Object? error}) = UiError<T>;

  R when<R>({
    required R Function() init,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message, Object? error) error,
  }) {
    return switch (this) {
      UiInit<T>() => init(),
      UiLoading<T>() => loading(),
      UiSuccess<T>(data: final data) => success(data),
      UiError<T>(message: final msg, error: final err) => error(msg, err),
    };
  }
}

final class UiInit<T> extends UiState<T> {
  const UiInit();
}

final class UiLoading<T> extends UiState<T> {
  const UiLoading();
}

final class UiSuccess<T> extends UiState<T> {
  final T data;
  const UiSuccess(this.data);
}

final class UiError<T> extends UiState<T> {
  final String message;
  final Object? error;
  const UiError(this.message, {this.error});
}
