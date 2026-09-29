import '../models/breadcrumb.dart';

abstract interface class CrashReporterContract {
  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
    Map<String, Object?>? context,
  });

  void addBreadcrumb(Breadcrumb breadcrumb);

  Future<void> setUserId(String? userId);

  Future<void> setCustomKey(String key, Object value);
}
