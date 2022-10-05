import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../test/presentation/provider/tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GettvDetail,
  GettvRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late tvDetailNotifier provider;
  late MockGettvDetail mockGettvDetail;
  late MockGettvRecommendations mockGettvRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGettvDetail = MockGettvDetail();
    mockGettvRecommendations = MockGettvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = tvDetailNotifier(
      gettvDetail: mockGettvDetail,
      gettvRecommendations: mockGettvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 31917;

  final ttv = tv(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview: "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originalCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars"
  );
  final ttvs = <tv>[ttv];

  void _arrangeUsecase() {
    when(mockGettvDetail.execute(tId))
        .thenAnswer((_) async => Right(testtvDetail));
    when(mockGettvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(ttvs));
  }

  group('Get tv Show Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchtvDetail(tId);
      // assert
      verify(mockGettvDetail.execute(tId));
      verify(mockGettvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchtvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchtvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvs, testtvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchtvDetail(tId);
          // assert
          expect(provider.tvState, RequestState.loaded);
          expect(provider.tvRecommendations, ttvs);
        });
  });

  group('Get tv Show Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchtvDetail(tId);
      // assert
      verify(mockGettvRecommendations.execute(tId));
      expect(provider.tvRecommendations, ttvs);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchtvDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.loaded);
          expect(provider.tvRecommendations, ttvs);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGettvDetail.execute(tId))
          .thenAnswer((_) async => Right(testtvDetail));
      when(mockGettvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchtvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute2(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute2(testtvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute2(testtvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testtvDetail);
      // assert
      verify(mockSaveWatchlist.execute2(testtvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute2(testtvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute2(testtvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testtvDetail);
      // assert
      verify(mockRemoveWatchlist.execute2(testtvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute2(testtvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute2(testtvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testtvDetail);
      // assert
      verify(mockGetWatchlistStatus.execute2(testtvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute2(testtvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute2(testtvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testtvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGettvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGettvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(ttvs));
      // act
      await provider.fetchtvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
