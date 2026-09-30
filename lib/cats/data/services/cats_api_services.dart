import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:networking/networking.dart';

part 'cats_api_services.g.dart';

@RestApi()
abstract class CatsApiServices {
  factory CatsApiServices(Dio dio, {String? baseUrl}) = _CatsApiServices;

  @GET('/breeds')
  Future<HttpResponse<List<CatDto>>> getCats();
}
