import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';

import '../../../test/presentation/provider/tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirtvs, GetPopulartvs, GetTopRatedtvs])
void main() {
  late tvListNotifier provider;
  late MockGetOnAirtvs mockGetOnAirtvs;
  late MockGetPopulartvs mockGetPopulartvs;
  late MockGetTopRatedtvs mockGetTopRatedtvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirtvs = MockGetOnAirtvs();
    mockGetPopulartvs = MockGetPopulartvs();
    mockGetTopRatedtvs = MockGetTopRatedtvs();
    provider = tvListNotifier(
      getOnAirtvs: mockGetOnAirtvs,
      getPopulartvs: mockGetPopulartvs,
      getTopRatedtvs: mockGetTopRatedtvs,
    )..addListener(() {
      listenerCallCount += 1;
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

  group('on air tv shows', () {
    test('initialState should be Empty', () {
      expect(provider.onAirState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirtvs.execute())
          .thenAnswer((_) async => Right(ttvList));
      // act
      provider.fetchOnAirtvs();
      // assert
      verify(mockGetOnAirtvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirtvs.execute())
          .thenAnswer((_) async => Right(ttvList));
      // act
      provider.fetchOnAirtvs();
      // assert
      expect(provider.onAirState, RequestState.loading);
    });

    test('should change tv shows when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirtvs.execute())
          .thenAnswer((_) async => Right(ttvList));
      // act
      await provider.fetchOnAirtvs();
      // assert
      expect(provider.onAirState, RequestState.loaded);
      expect(provider.onAirtvs, ttvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirtvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirtvs();
      // assert
      expect(provider.onAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopulartvs.execute())
          .thenAnswer((_) async => Right(ttvList));
      // act
      provider.fetchPopulartvs();
      // assert
      expect(provider.populartvsState, RequestState.loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopulartvs.execute())
              .thenAnswer((_) async => Right(ttvList));
          // act
          await provider.fetchPopulartvs();
          // assert
          expect(provider.populartvsState, RequestState.loaded);
          expect(provider.populartvs, ttvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopulartvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopulartvs();
      // assert
      expect(provider.populartvsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedtvs.execute())
          .thenAnswer((_) async => Right(ttvList));
      // act
      provider.fetchTopRatedtvs();
      // assert
      expect(provider.topRatedtvsState, RequestState.loading);
    });

    test('should change movies data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedtvs.execute())
              .thenAnswer((_) async => Right(ttvList));
          // act
          await provider.fetchTopRatedtvs();
          // assert
          expect(provider.topRatedtvsState, RequestState.loaded);
          expect(provider.topRatedtvs, ttvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedtvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedtvs();
      // assert
      expect(provider.topRatedtvsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
