import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/watchlist_detail_bloc.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'watchlist_detail_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistDetailBloc watchlistDetailBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistDetailBloc = WatchlistDetailBloc(mockGetWatchlistMovies, mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistDetailBloc.state, WatchlistDetailEmpty());
  });

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, HasData] when data watchlist is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailHasData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, Empty] when data watchlist is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([]));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, HasData] when data is successfully added to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, Error] when data added to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, HasData] when data is successfully removed to watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistDetailBloc, WatchlistDetailState>(
    'Should emit [Loading, Error] when data removed from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailLoading(),
      WatchlistDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}