import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';

abstract interface class CatsDatasourceLocal {
  List<CatDto> fetchCats();

  void saveCats(List<CatDto> cats);

  CatDto? getCatById(String catId);
}
