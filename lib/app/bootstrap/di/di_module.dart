import 'dart:async';
import 'package:get_it/get_it.dart';

abstract interface class DiModule {
  FutureOr<void> register(GetIt sl);
}
