import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/watchlist_tv_notifier.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlisttvs])
void main() {
  late WatchlisttvNotifier provider;
  late MockGetWatchlisttvs mockGetWatchlisttvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlisttvs = MockGetWatchlisttvs();
    provider = WatchlisttvNotifier(
      getWatchlisttvs: mockGetWatchlisttvs,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlisttvs.execute())
        .thenAnswer((_) async => Right([testWatchlisttv]));
    // act
    await provider.fetchWatchlisttvs();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlisttvs, [testWatchlisttv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlisttvs.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlisttvs();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
