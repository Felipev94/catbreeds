import 'package:bloc_signals/bloc_signals.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/ui/home/view_model/event/cats_event.dart';
import 'package:catbreeds/cats/ui/home/view_model/state/cats_state.dart';
import 'package:core/core.dart';

import '../../../data/repositories/entities/cat.dart';

class CatsViewModel extends BlocSignal<CatsEvent, CatsState> {
  final CatsRepository _catsRepository;

  CatsViewModel(this._catsRepository) : super(initialState: CatsState()) {
    on<FetchCats>(_fetchCatsHandler);
    on<SearchCats>(_searchCatsHandler);
  }

  Future<void> _fetchCatsHandler(
    CatsEvent event,
    void Function(CatsState) emit,
  ) async {
    final Either<Failure, List<Cat>> response = await _catsRepository
        .fetchCats();

    response.fold(
      (Failure failure) => emit(CatsState(cats: UiError(failure.message))),
      (List<Cat> ctas) => emit(CatsState(cats: UiState.success(ctas))),
    );
  }

  Future<void> _searchCatsHandler(
    SearchCats event,
    void Function(CatsState) emit,
  ) async {}
}
