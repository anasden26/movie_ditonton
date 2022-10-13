import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/detail_bloc.dart';
import 'package:movie/presentation/bloc/popular_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_detail_bloc.dart';
import 'package:tv/presentation/bloc/detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv/tv.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
        () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => SearchBlocTv(
      locator(),
    ),
  );
  locator.registerFactory(
        () => DetailBloc(
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
        () => DetailTvBloc(
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
        () => NowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => OnAirTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistDetailBloc(
      locator(),
      locator(),
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
        () => WatchlistDetailTvBloc(
      locator(),
      locator(),
      locator(),
      locator()
    ),
  );
  locator.registerFactory(
        () => WatchlistTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => SeasonDetailBlocTv(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetOnAirTVs(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator(), locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator(), locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
