import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVs])
void main() {
  late SearchBlocTv searchBloc;
  late MockSearchTVs mockSearchTVs;

  setUp(() {
    mockSearchTVs = MockSearchTVs();
    searchBloc = SearchBlocTv(mockSearchTVs);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmptyTv());
  });

  final ttvModel = TV(
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
  final ttvList = <TV>[ttvModel];
  final tQuery = 'pretty';

  blocTest<SearchBlocTv, SearchStateTv>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Right(ttvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoadingTv(),
      SearchHasDataTv(ttvList),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tQuery));
    },
  );

  blocTest<SearchBlocTv, SearchStateTv>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVs.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoadingTv(),
      SearchErrorTv('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVs.execute(tQuery));
    },
  );
}