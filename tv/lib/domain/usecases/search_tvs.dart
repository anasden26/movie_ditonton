import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class SearchTVs {
  final TVRepository repository;

  SearchTVs(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTVs(query);
  }
}
