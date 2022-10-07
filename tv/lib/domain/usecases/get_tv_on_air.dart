import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/common/failure.dart';

class GetOnAirTVs {
  final TVRepository repository;

  GetOnAirTVs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTVOnTheAir();
  }
}
