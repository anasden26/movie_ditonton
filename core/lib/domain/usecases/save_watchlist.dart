import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class SaveWatchlist {
  final MovieRepository repository1;
  final TVRepository repository2;

  SaveWatchlist(this.repository1, this.repository2);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository1.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> execute2(TVDetail tv) {
    return repository2.saveWatchlist(tv);
  }
}
