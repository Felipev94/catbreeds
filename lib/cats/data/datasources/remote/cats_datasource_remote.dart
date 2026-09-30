import 'package:core/core.dart';

import '../dtos/cat_dto.dart';

abstract interface class CatsDatasourceRemote {
  Future<ApiResponse<List<CatDto>>> fetchCats();
}
