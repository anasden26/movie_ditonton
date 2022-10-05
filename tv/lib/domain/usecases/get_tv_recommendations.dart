import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GettvRecommendations {
  final tvRepository repository;

  GettvRecommendations(this.repository);

  Future<Either<Failure, List<tv>>> execute(id) {
    return repository.gettvRecommendations(id);
  }
}
