import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchlisttvs {
  final tvRepository _repository;

  GetWatchlisttvs(this._repository);

  Future<Either<Failure, List<tv>>> execute() {
    return _repository.getWatchlisttv();
  }
}
