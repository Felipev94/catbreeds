import 'package:core/core.dart';

import 'cats_datasource_remote.dart';
import '../dtos/cat_dto.dart';
import '../../services/cats_api_services.dart';

class CatsDatasourceRemoteImpl implements CatsDatasourceRemote {
  final CatsApiServices _catsApiServices;

  const CatsDatasourceRemoteImpl(this._catsApiServices);

  @override
  Future<ApiResponse<List<CatDto>>> fetchCats() {
    return NetworkGuard.execute(() => _catsApiServices.getCats());
  }
}
