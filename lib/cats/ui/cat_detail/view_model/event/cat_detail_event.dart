sealed class CatDetailEvent {}

class FetchCatDetail extends CatDetailEvent {
  final String catId;
  FetchCatDetail(this.catId);
}

class RetryCatDetail extends CatDetailEvent {
  final String catId;
  RetryCatDetail(this.catId);
}
