import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class RemoveWatchlist {
  final MovieRepository repository;
  final TVRepository repository2;

  RemoveWatchlist(this.repository, this.repository2);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> execute2(TVDetail tv) {
    return repository2.removeWatchlist(tv);
  }
}
