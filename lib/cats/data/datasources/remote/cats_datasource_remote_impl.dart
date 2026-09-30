import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/services/cats_api_services.dart';
import 'package:networking/networking.dart';

import 'cats_datasource_remote.dart';

class CatsDatasourceRemoteImpl implements CatsDatasourceRemote {
  final CatsApiServices _catsApiServices;

  const CatsDatasourceRemoteImpl(this._catsApiServices);

  @override
  Future<ApiResponse<List<CatDto>>> fetchCats() {
    return NetworkGuard.execute(() => _catsApiServices.getCats());
  }
}
