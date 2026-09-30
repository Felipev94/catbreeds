import 'package:core/core.dart';

import 'cats_repository.dart';
import 'entities/cat.dart';
import 'mappers/cat_dto_mapper.dart';
import '../datasources/dtos/cat_dto.dart';
import '../datasources/local/cats_datasource_local.dart';
import '../datasources/remote/cats_datasource_remote.dart';

class CatsRepositoryImpl implements CatsRepository {
  final CatsDatasourceLocal _datasourceLocal;
  final CatsDatasourceRemote _datasourceRemote;

  const CatsRepositoryImpl(this._datasourceLocal, this._datasourceRemote);

  @override
  Future<Either<Failure, List<Cat>>> fetchCats() async {
    final List<CatDto> cacheResponse = _datasourceLocal.fetchCats();
    if (cacheResponse.isNotEmpty) {
      return Right(cacheResponse.map((cat) => cat.toEntity()).toList());
    }

    final ApiResponse<List<CatDto>> remoteResponse = await _fetchCats();

    return remoteResponse.fold(
      onSuccess: (List<CatDto> cats) {
        _datasourceLocal.saveCats(cats);
        return Right(cats.map((cat) => cat.toEntity()).toList());
      },
      onError: (Failure failure) {
        return left(failure);
      },
    );
  }

  @override
  Future<Either<Failure, Cat>> getCatById(String catId) async {
    final CatDto? cacheResponse = _datasourceLocal.getCatById(catId);
    if (cacheResponse != null) return Right(cacheResponse.toEntity());

    final ApiResponse<List<CatDto>> remoteResponse = await _fetchCats();

    return remoteResponse.fold(
      onSuccess: (List<CatDto> cats) {
        final bool catExist = cats.any((cat) => cat.id == catId);
        if (catExist) {
          final CatDto cat = cats.firstWhere((cat) => cat.id == catId);
          _datasourceLocal.saveCat(cat);
          return Right(cat.toEntity());
        }

        return Left(ServerFailure('Cat not found.', statusCode: 404));
      },
      onError: (Failure failure) {
        return Left(failure);
      },
    );
  }

  Future<ApiResponse<List<CatDto>>> _fetchCats() async {
    return await _datasourceRemote.fetchCats();
  }
}
