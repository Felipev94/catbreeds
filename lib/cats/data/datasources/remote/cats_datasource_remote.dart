import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:networking/networking.dart';

abstract interface class CatsDatasourceRemote {
  Future<ApiResponse<List<CatDto>>> fetchCats();
}
