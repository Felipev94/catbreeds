import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:core/core.dart';

class CatsState {
  final UiState<List<Cat>> cats;

  const CatsState({this.cats = const UiInit<List<Cat>>()});

  CatsState copyWith({UiState<List<Cat>>? cats}) =>
      CatsState(cats: cats ?? this.cats);
}
