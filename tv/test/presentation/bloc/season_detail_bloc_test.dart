import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/season_detail_bloc.dart';
import 'package:tv/tv.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonDetail])
void main() {
  late SeasonDetailBlocTv seasonDetailBlocTv;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    seasonDetailBlocTv = SeasonDetailBlocTv(mockGetSeasonDetail);
  });

  test('initial state should be empty', () {
    expect(seasonDetailBlocTv.state, SeasonDetailEmptyTv());
  });

  final tId = 43395;
  final tSeason = 0;

  blocTest<SeasonDetailBlocTv, SeasonDetailStateTv>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeasonDetail.execute(tId, tSeason))
          .thenAnswer((_) async => Right(testSeasonDetail));
      return seasonDetailBlocTv;
    },
    act: (bloc) => bloc.add(fetchSeasonDetail(tId, tSeason)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeasonDetailLoadingTv(),
      SeasonDetailHasDataTv(testSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeasonDetail.execute(tId, tSeason));
    },
  );

  blocTest<SeasonDetailBlocTv, SeasonDetailStateTv>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetSeasonDetail.execute(tId, tSeason))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seasonDetailBlocTv;
    },
    act: (bloc) => bloc.add(fetchSeasonDetail(tId, tSeason)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeasonDetailLoadingTv(),
      SeasonDetailErrorTv('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeasonDetail.execute(tId, tSeason));
    },
  );
}