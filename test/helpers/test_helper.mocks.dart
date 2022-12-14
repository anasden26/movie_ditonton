// Mocks generated by Mockito 5.3.2 from annotations
// in movie_ditonton_2/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:convert' as _i22;
import 'dart:typed_data' as _i23;

import 'package:core/core.dart' as _i10;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i6;
import 'package:http/io_client.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/models/movie_detail_model.dart' as _i3;
import 'package:movie/data/models/movie_model.dart' as _i17;
import 'package:movie/data/models/movie_table.dart' as _i19;
import 'package:movie/domain/entities/movie.dart' as _i11;
import 'package:movie/domain/entities/movie_detail.dart' as _i12;
import 'package:movie/movie.dart' as _i8;
import 'package:sqflite/sqflite.dart' as _i21;
import 'package:tv/data/models/season_detail_model.dart' as _i5;
import 'package:tv/data/models/tv_detail_model.dart' as _i4;
import 'package:tv/data/models/tv_model.dart' as _i18;
import 'package:tv/data/models/tv_table.dart' as _i20;
import 'package:tv/domain/entities/season_detail.dart' as _i16;
import 'package:tv/domain/entities/tv.dart' as _i14;
import 'package:tv/domain/entities/tv_detail.dart' as _i15;
import 'package:tv/tv.dart' as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTVDetailResponse_2 extends _i1.SmartFake
    implements _i4.TVDetailResponse {
  _FakeTVDetailResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSeasonDetailResponse_3 extends _i1.SmartFake
    implements _i5.SeasonDetailResponse {
  _FakeSeasonDetailResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_4 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_5 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOStreamedResponse_6 extends _i1.SmartFake
    implements _i7.IOStreamedResponse {
  _FakeIOStreamedResponse_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i8.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingMovies,
              [],
            ),
            returnValue:
                _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                    _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
              this,
              Invocation.method(
                #getNowPlayingMovies,
                [],
              ),
            )),
          ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>.value(
                _FakeEither_0<_i10.Failure, _i12.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getMovieRecommendations,
              [id],
            ),
            returnValue:
                _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                    _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
              this,
              Invocation.method(
                #getMovieRecommendations,
                [id],
              ),
            )),
          ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
            _FakeEither_0<_i10.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
            _FakeEither_0<_i10.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
          this,
          Invocation.method(
            #getWatchlistMovies,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
}

/// A class which mocks [TVRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRepository extends _i1.Mock implements _i13.TVRepository {
  MockTVRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> getTVOnTheAir() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVOnTheAir,
          [],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #getTVOnTheAir,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> getPopularTVs() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTVs,
          [],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #getPopularTVs,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> getTopRatedTVs() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTVs,
          [],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #getTopRatedTVs,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i15.TVDetail>> getTVDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVDetail,
          [id],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, _i15.TVDetail>>.value(
            _FakeEither_0<_i10.Failure, _i15.TVDetail>(
          this,
          Invocation.method(
            #getTVDetail,
            [id],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, _i15.TVDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> getTVRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVRecommendations,
          [id],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #getTVRecommendations,
            [id],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> searchTVs(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTVs,
          [query],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #searchTVs,
            [query],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i15.TVDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [tv],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
            _FakeEither_0<_i10.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [tv],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i15.TVDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tv],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
            _FakeEither_0<_i10.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tv],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>> getWatchlistTV() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTV,
          [],
        ),
        returnValue: _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>.value(
            _FakeEither_0<_i10.Failure, List<_i14.TV>>(
          this,
          Invocation.method(
            #getWatchlistTV,
            [],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, List<_i14.TV>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i16.SeasonDetail>> getSeasonDetail(
    int? id,
    int? season,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeasonDetail,
          [
            id,
            season,
          ],
        ),
        returnValue:
            _i9.Future<_i2.Either<_i10.Failure, _i16.SeasonDetail>>.value(
                _FakeEither_0<_i10.Failure, _i16.SeasonDetail>(
          this,
          Invocation.method(
            #getSeasonDetail,
            [
              id,
              season,
            ],
          ),
        )),
      ) as _i9.Future<_i2.Either<_i10.Failure, _i16.SeasonDetail>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i8.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i17.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i9.Future<List<_i17.MovieModel>>.value(<_i17.MovieModel>[]),
      ) as _i9.Future<List<_i17.MovieModel>>);
  @override
  _i9.Future<List<_i17.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i9.Future<List<_i17.MovieModel>>.value(<_i17.MovieModel>[]),
      ) as _i9.Future<List<_i17.MovieModel>>);
  @override
  _i9.Future<List<_i17.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i9.Future<List<_i17.MovieModel>>.value(<_i17.MovieModel>[]),
      ) as _i9.Future<List<_i17.MovieModel>>);
  @override
  _i9.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i9.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i9.Future<_i3.MovieDetailResponse>);
  @override
  _i9.Future<List<_i17.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i9.Future<List<_i17.MovieModel>>.value(<_i17.MovieModel>[]),
      ) as _i9.Future<List<_i17.MovieModel>>);
  @override
  _i9.Future<List<_i17.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i9.Future<List<_i17.MovieModel>>.value(<_i17.MovieModel>[]),
      ) as _i9.Future<List<_i17.MovieModel>>);
}

/// A class which mocks [TVRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRemoteDataSource extends _i1.Mock
    implements _i13.TVRemoteDataSource {
  MockTVRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i18.TVModel>> getTVOnTheAir() => (super.noSuchMethod(
        Invocation.method(
          #getTVOnTheAir,
          [],
        ),
        returnValue: _i9.Future<List<_i18.TVModel>>.value(<_i18.TVModel>[]),
      ) as _i9.Future<List<_i18.TVModel>>);
  @override
  _i9.Future<List<_i18.TVModel>> getPopularTVs() => (super.noSuchMethod(
        Invocation.method(
          #getPopularTVs,
          [],
        ),
        returnValue: _i9.Future<List<_i18.TVModel>>.value(<_i18.TVModel>[]),
      ) as _i9.Future<List<_i18.TVModel>>);
  @override
  _i9.Future<List<_i18.TVModel>> getTopRatedTVs() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTVs,
          [],
        ),
        returnValue: _i9.Future<List<_i18.TVModel>>.value(<_i18.TVModel>[]),
      ) as _i9.Future<List<_i18.TVModel>>);
  @override
  _i9.Future<_i4.TVDetailResponse> getTVDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTVDetail,
          [id],
        ),
        returnValue:
            _i9.Future<_i4.TVDetailResponse>.value(_FakeTVDetailResponse_2(
          this,
          Invocation.method(
            #getTVDetail,
            [id],
          ),
        )),
      ) as _i9.Future<_i4.TVDetailResponse>);
  @override
  _i9.Future<List<_i18.TVModel>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTVRecommendations,
          [id],
        ),
        returnValue: _i9.Future<List<_i18.TVModel>>.value(<_i18.TVModel>[]),
      ) as _i9.Future<List<_i18.TVModel>>);
  @override
  _i9.Future<List<_i18.TVModel>> searchTVs(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTVs,
          [query],
        ),
        returnValue: _i9.Future<List<_i18.TVModel>>.value(<_i18.TVModel>[]),
      ) as _i9.Future<List<_i18.TVModel>>);
  @override
  _i9.Future<_i5.SeasonDetailResponse> getSeasonDetail(
    int? id,
    int? season,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeasonDetail,
          [
            id,
            season,
          ],
        ),
        returnValue: _i9.Future<_i5.SeasonDetailResponse>.value(
            _FakeSeasonDetailResponse_3(
          this,
          Invocation.method(
            #getSeasonDetail,
            [
              id,
              season,
            ],
          ),
        )),
      ) as _i9.Future<_i5.SeasonDetailResponse>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i8.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<_i19.MovieTable?> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i9.Future<_i19.MovieTable?>.value(),
      ) as _i9.Future<_i19.MovieTable?>);
  @override
  _i9.Future<List<_i19.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i9.Future<List<_i19.MovieTable>>.value(<_i19.MovieTable>[]),
      ) as _i9.Future<List<_i19.MovieTable>>);
}

/// A class which mocks [TVLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVLocalDataSource extends _i1.Mock implements _i13.TVLocalDataSource {
  MockTVLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i20.TVTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tv],
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i20.TVTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tv],
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<_i20.TVTable?> getTVById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTVById,
          [id],
        ),
        returnValue: _i9.Future<_i20.TVTable?>.value(),
      ) as _i9.Future<_i20.TVTable?>);
  @override
  _i9.Future<List<_i20.TVTable>> getWatchlistTV() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTV,
          [],
        ),
        returnValue: _i9.Future<List<_i20.TVTable>>.value(<_i20.TVTable>[]),
      ) as _i9.Future<List<_i20.TVTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i10.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i21.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i9.Future<_i21.Database?>.value(),
      ) as _i9.Future<_i21.Database?>);
  @override
  _i9.Future<int> insertWatchlistMovie(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistMovie,
          [movie],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlistMovie(_i19.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<int> insertWatchlistTv(_i20.TVTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistTv,
          [tv],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlistTv(_i20.TVTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTv,
          [tv],
        ),
        returnValue: _i9.Future<int>.value(0),
      ) as _i9.Future<int>);
  @override
  _i9.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i9.Future<Map<String, dynamic>?>.value(),
      ) as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<Map<String, dynamic>?> getTvById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvById,
          [id],
        ),
        returnValue: _i9.Future<Map<String, dynamic>?>.value(),
      ) as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i9.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i9.Future<List<Map<String, dynamic>>>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i9.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i9.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i6.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i6.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<_i23.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i23.Uint8List>.value(_i23.Uint8List(0)),
      ) as _i9.Future<_i23.Uint8List>);
  @override
  _i9.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i9.Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_5(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i9.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i7.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i7.IOStreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i9.Future<_i7.IOStreamedResponse>.value(_FakeIOStreamedResponse_6(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i9.Future<_i7.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i9.Future<_i6.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i22.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<String>.value(''),
      ) as _i9.Future<String>);
  @override
  _i9.Future<_i23.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i9.Future<_i23.Uint8List>.value(_i23.Uint8List(0)),
      ) as _i9.Future<_i23.Uint8List>);
}
