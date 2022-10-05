import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class GettvDetail {
  final tvRepository repository;

  GettvDetail(this.repository);

  Future<Either<Failure, tvDetail>> execute(int id) {
    return repository.gettvDetail(id);
  }
}
