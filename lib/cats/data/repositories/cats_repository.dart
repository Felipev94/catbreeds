import 'package:core/core.dart';

import 'entities/cat.dart';

abstract interface class CatsRepository {
  Future<Either<Failure, List<Cat>>> fetchCats();

  Future<Either<Failure, Cat>> getCatById(String catId);
}
