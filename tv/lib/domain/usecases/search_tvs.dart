import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class Searchtvs {
  final tvRepository repository;

  Searchtvs(this.repository);

  Future<Either<Failure, List<tv>>> execute(String query) {
    return repository.searchtvs(query);
  }
}
