import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';

abstract interface class CatsDatasourceLocal {
  List<CatDto> fetchCats();

  void saveCats(List<CatDto> cats);

  void saveCat(CatDto cat);

  CatDto? getCatById(String catId);
}
