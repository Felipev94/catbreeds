import 'package:bloc_signals/bloc_signals.dart';
import 'package:catbreeds/cats/data/repositories/cats_repository.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/event/cat_detail_event.dart';
import 'package:catbreeds/cats/ui/cat_detail/view_model/state/cat_detail_state.dart';
import 'package:core/core.dart';

class CatDetailViewModel extends BlocSignal<CatDetailEvent, CatDetailState> {
  final CatsRepository _catsRepository;

  CatDetailViewModel(this._catsRepository)
    : super(initialState: const CatDetailState()) {
    on<FetchCatDetail>(_fetchCatDetailHandler);
    on<RetryCatDetail>(_retryCatDetailHandler);
  }

  Future<void> _fetchCatDetailHandler(
    FetchCatDetail event,
    void Function(CatDetailState) emit,
  ) async {
    emit(CatDetailState(cat: UiState.loading()));

    final Either<Failure, Cat> response = await _catsRepository.getCatById(
      event.catId,
    );

    response.fold(
      (Failure failure) =>
          emit(CatDetailState(cat: UiError<Cat>(failure.message))),
      (Cat cat) => emit(CatDetailState(cat: UiState.success(cat))),
    );
  }

  Future<void> _retryCatDetailHandler(
    RetryCatDetail event,
    void Function(CatDetailState) emit,
  ) async {
    await _fetchCatDetailHandler(FetchCatDetail(event.catId), emit);
  }
}
