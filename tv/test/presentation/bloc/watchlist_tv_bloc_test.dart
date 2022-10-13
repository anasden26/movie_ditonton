import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv/tv.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTVs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTVs mockGetWatchlistTVs;

  setUp(() {
    mockGetWatchlistTVs = MockGetWatchlistTVs();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTVs);
  });

  test('initial state should be empty', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(OnLoadTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData([testWatchlistTv]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(OnLoadTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVs.execute());
    },
  );
}