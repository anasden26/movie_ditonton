import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';

import '../../../test/presentation/provider/top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedtvs])
void main() {
  late MockGetTopRatedtvs mockGetTopRatedtvs;
  late TopRatedtvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedtvs = MockGetTopRatedtvs();
    notifier = TopRatedtvsNotifier(getTopRatedtvs: mockGetTopRatedtvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  final ttvList = <tv>[ttv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedtvs.execute())
        .thenAnswer((_) async => Right(ttvList));
    // act
    notifier.fetchTopRatedtvs();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedtvs.execute())
        .thenAnswer((_) async => Right(ttvList));
    // act
    await notifier.fetchTopRatedtvs();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvs, ttvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedtvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedtvs();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}