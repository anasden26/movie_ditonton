import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:tv/tv.dart';

import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTVRecommendations])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTVRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVRecommendations = MockGetTVRecommendations();
    recommendationTvBloc = RecommendationTvBloc(mockGetTVRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationTvBloc.state, RecommendationTvEmpty());
  });

  final tId = 31917;

  final tTvModel = TV(
      posterPath: "/aUPbHiLS3hCHKjtLsncFa9g0viV.jpg",
      popularity: 47.432451,
      id: 31917,
      backdropPath: "/ypLoTftyF5EpGBxJas4PThIdiU4.jpg",
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
  final tTvList = <TV>[tTvModel];

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(OnLoadRecommendation(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(tId));
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(OnLoadRecommendation(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(tId));
    },
  );
}