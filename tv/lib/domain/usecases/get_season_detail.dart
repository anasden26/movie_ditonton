import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/season_detail.dart';
import '../repositories/tv_repository.dart';

class GetSeasonDetail {
  final tvRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int season) {
    return repository.getSeasonDetail(id, season);
  }
}
