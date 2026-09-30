import 'package:flutter/material.dart';

import 'cache_client.dart';

class MemoryCacheClient implements CacheClient {
  final Map<String, dynamic> _store = {};

  static MemoryCacheClient? _instance;

  MemoryCacheClient._internal();

  factory MemoryCacheClient() {
    _instance ??= MemoryCacheClient._internal();
    return _instance!;
  }

  @visibleForTesting
  static void resetInstanceForTesting() {
    _instance?._store.clear();
    _instance = null;
  }

  @override
  T? read<T>({required String key}) {
    final dynamic entry = _store[key];
    if (entry == null) return null;

    return entry as T?;
  }

  @override
  List<T> readAll<T>() {
    return _store.values.cast<T>().toList();
  }

  @override
  void write<T>({required String key, required T value}) {
    _store[key] = value;
  }

  @override
  void delete({required String key}) {
    _store.remove(key);
  }

  @override
  void clear() {
    _store.clear();
  }

  @override
  bool containsKey({required String key}) {
    final entry = _store[key];
    if (entry == null) return false;
    return true;
  }
}
