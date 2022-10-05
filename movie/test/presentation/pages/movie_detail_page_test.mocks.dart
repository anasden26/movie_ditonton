// Mocks generated by Mockito 5.3.2 from annotations
// in movie/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:core/core.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie.dart' as _i7;
import 'package:movie/domain/entities/movie_detail.dart' as _i5;
import 'package:movie/domain/usecases/get_movie_detail.dart' as _i2;
import 'package:movie/domain/usecases/get_movie_recommendations.dart' as _i3;
import 'package:movie/presentation/provider/movie_detail_notifier.dart' as _i6;

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

class _FakeGetMovieDetail_0 extends _i1.SmartFake
    implements _i2.GetMovieDetail {
  _FakeGetMovieDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetMovieRecommendations_1 extends _i1.SmartFake
    implements _i3.GetMovieRecommendations {
  _FakeGetMovieRecommendations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchListStatus_2 extends _i1.SmartFake
    implements _i4.GetWatchListStatus {
  _FakeGetWatchListStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlist_3 extends _i1.SmartFake implements _i4.SaveWatchlist {
  _FakeSaveWatchlist_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlist_4 extends _i1.SmartFake
    implements _i4.RemoveWatchlist {
  _FakeRemoveWatchlist_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetail_5 extends _i1.SmartFake implements _i5.MovieDetail {
  _FakeMovieDetail_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailNotifier extends _i1.Mock
    implements _i6.MovieDetailNotifier {
  MockMovieDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail => (super.noSuchMethod(
        Invocation.getter(#getMovieDetail),
        returnValue: _FakeGetMovieDetail_0(
          this,
          Invocation.getter(#getMovieDetail),
        ),
      ) as _i2.GetMovieDetail);
  @override
  _i3.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getMovieRecommendations),
        returnValue: _FakeGetMovieRecommendations_1(
          this,
          Invocation.getter(#getMovieRecommendations),
        ),
      ) as _i3.GetMovieRecommendations);
  @override
  _i4.GetWatchListStatus get getWatchListStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListStatus),
        returnValue: _FakeGetWatchListStatus_2(
          this,
          Invocation.getter(#getWatchListStatus),
        ),
      ) as _i4.GetWatchListStatus);
  @override
  _i4.SaveWatchlist get saveWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveWatchlist),
        returnValue: _FakeSaveWatchlist_3(
          this,
          Invocation.getter(#saveWatchlist),
        ),
      ) as _i4.SaveWatchlist);
  @override
  _i4.RemoveWatchlist get removeWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeWatchlist),
        returnValue: _FakeRemoveWatchlist_4(
          this,
          Invocation.getter(#removeWatchlist),
        ),
      ) as _i4.RemoveWatchlist);
  @override
  _i5.MovieDetail get movie => (super.noSuchMethod(
        Invocation.getter(#movie),
        returnValue: _FakeMovieDetail_5(
          this,
          Invocation.getter(#movie),
        ),
      ) as _i5.MovieDetail);
  @override
  _i4.RequestState get movieState => (super.noSuchMethod(
        Invocation.getter(#movieState),
        returnValue: _i4.RequestState.empty,
      ) as _i4.RequestState);
  @override
  List<_i7.Movie> get movieRecommendations => (super.noSuchMethod(
        Invocation.getter(#movieRecommendations),
        returnValue: <_i7.Movie>[],
      ) as List<_i7.Movie>);
  @override
  _i4.RequestState get recommendationState => (super.noSuchMethod(
        Invocation.getter(#recommendationState),
        returnValue: _i4.RequestState.empty,
      ) as _i4.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get isAddedToWatchlist => (super.noSuchMethod(
        Invocation.getter(#isAddedToWatchlist),
        returnValue: false,
      ) as bool);
  @override
  String get watchlistMessage => (super.noSuchMethod(
        Invocation.getter(#watchlistMessage),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchMovieDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchMovieDetail,
          [id],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> addWatchlist(_i5.MovieDetail? movie) => (super.noSuchMethod(
        Invocation.method(
          #addWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> removeFromWatchlist(_i5.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [movie],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
        Invocation.method(
          #loadWatchlistStatus,
          [id],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
