import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/common/failure.dart';

class GetSeasonDetail {
  final TVRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int season) {
    return repository.getSeasonDetail(id, season);
  }
}
