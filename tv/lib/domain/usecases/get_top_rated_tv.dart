import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedtvs {
  final tvRepository repository;

  GetTopRatedtvs(this.repository);

  Future<Either<Failure, List<tv>>> execute() {
    return repository.getTopRatedtvs();
  }
}
