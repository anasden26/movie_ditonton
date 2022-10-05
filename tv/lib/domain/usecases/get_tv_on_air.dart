import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetOnAirtvs {
  final tvRepository repository;

  GetOnAirtvs(this.repository);

  Future<Either<Failure, List<tv>>> execute() {
    return repository.gettvOnTheAir();
  }
}
