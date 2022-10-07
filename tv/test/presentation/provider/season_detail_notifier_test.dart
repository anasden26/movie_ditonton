import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/season_detail_notifier.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetSeasonDetail])
void main() {
  late SeasonDetailNotifier provider;
  late MockGetSeasonDetail mockGetSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonDetail = MockGetSeasonDetail();
    provider = SeasonDetailNotifier(
      getSeasonDetail: mockGetSeasonDetail
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 31917;

  final tSeason = Season(
    airDate: "2012-08-28",
    episodeCount: 11,
    id: 43395,
    name: "Specials",
    overview: "",
    posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg",
    seasonNumber: 0,
  );

  void _arrangeUsecase() {
    when(mockGetSeasonDetail.execute(tId, tSeason.seasonNumber))
        .thenAnswer((_) async => Right(testSeasonDetail));
  }

  group('Get Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeason.seasonNumber);
      // assert
      verify(mockGetSeasonDetail.execute(tId, tSeason.seasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeasonDetail(tId, tSeason.seasonNumber);
      // assert
      expect(provider.seasonState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change to season detail when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeason.seasonNumber);
      // assert
      expect(provider.seasonState, RequestState.loaded);
      expect(provider.season, testSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeasonDetail.execute(tId, tSeason.seasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSeasonDetail(tId, tSeason.seasonNumber);
      // assert
      expect(provider.seasonState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
