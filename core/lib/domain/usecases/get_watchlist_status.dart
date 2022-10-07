import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;
  final TVRepository repository1;

  GetWatchListStatus(this.repository, this.repository1);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }

  Future<bool> execute2(int id) async {
    return repository1.isAddedToWatchlist(id);
  }
}
