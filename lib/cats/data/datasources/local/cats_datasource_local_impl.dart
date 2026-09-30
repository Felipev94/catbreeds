import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/datasources/local/cats_datasource_local.dart';
import 'package:core/core.dart';

class CatsDatasourceLocalImpl implements CatsDatasourceLocal {
  final CacheClient _cache;

  const CatsDatasourceLocalImpl(this._cache);

  @override
  List<CatDto> fetchCats() {
    return _cache.readAll<CatDto>();
  }

  @override
  CatDto? getCatById(String catId) {
    return _cache.read<CatDto>(key: catId);
  }

  @override
  void saveCats(List<CatDto> cats) {
    for (final CatDto cat in cats) {
      _cache.write<CatDto>(key: cat.id, value: cat);
    }
  }

  @override
  void saveCat(CatDto cat) {
    _cache.write<CatDto>(key: cat.id, value: cat);
  }
}
