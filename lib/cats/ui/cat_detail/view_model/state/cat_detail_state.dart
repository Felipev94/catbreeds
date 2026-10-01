import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:core/core.dart';

class CatDetailState {
  final UiState<Cat> cat;

  const CatDetailState({this.cat = const UiInit<Cat>()});

  CatDetailState copyWith({UiState<Cat>? cat}) =>
      CatDetailState(cat: cat ?? this.cat);
}
