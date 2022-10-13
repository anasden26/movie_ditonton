import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/watchlist_detail_tv_bloc.dart';
import 'package:tv/tv.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'watchlist_detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVs, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistDetailTvBloc watchlistDetailTvBloc;
  late MockGetWatchlistTVs mockGetWatchlistTVs;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistTVs = MockGetWatchlistTVs();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistDetailTvBloc = WatchlistDetailTvBloc(mockGetWatchlistTVs, mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistDetailTvBloc.state, WatchlistDetailTvEmpty());
  });

  // final tId = 31917;

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, HasData] when data watchlist is gotten successfully',
    build: () {
      when(mockGetWatchlistTVs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvHasData([testWatchlistTv]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVs.execute());
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, Empty] when data watchlist is gotten successfully',
    build: () {
      when(mockGetWatchlistTVs.execute())
          .thenAnswer((_) async => Right([]));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVs.execute());
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(CallWatchlist()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVs.execute());
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, HasData] when data is successfully added to watchlist',
    build: () {
      when(mockSaveWatchlist.execute2(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute2(testTvDetail));
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, Error] when data added to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute2(testTvDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute2(testTvDetail));
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, HasData] when data is successfully removed to watchlist',
    build: () {
      when(mockRemoveWatchlist.execute2(testTvDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute2(testTvDetail));
    },
  );

  blocTest<WatchlistDetailTvBloc, WatchlistDetailTvState>(
    'Should emit [Loading, Error] when data removed from watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute2(testTvDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistDetailTvBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistDetailTvLoading(),
      WatchlistDetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute2(testTvDetail));
    },
  );
}