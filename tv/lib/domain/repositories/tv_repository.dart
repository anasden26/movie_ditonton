import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/season_detail.dart';
import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class tvRepository {
  Future<Either<Failure, List<tv>>> gettvOnTheAir();
  Future<Either<Failure, List<tv>>> getPopulartvs();
  Future<Either<Failure, List<tv>>> getTopRatedtvs();
  Future<Either<Failure, tvDetail>> gettvDetail(int id);
  Future<Either<Failure, List<tv>>> gettvRecommendations(int id);
  Future<Either<Failure, List<tv>>> searchtvs(String query);
  Future<Either<Failure, String>> saveWatchlist(tvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(tvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<tv>>> getWatchlisttv();
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(int id, int season);
}
