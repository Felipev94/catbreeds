abstract class CacheClient {
  T? read<T>({required String key});

  List<T> readAll<T>();

  void write<T>({required String key, required T value});

  void delete({required String key});

  void clear();

  bool containsKey({required String key});
}
