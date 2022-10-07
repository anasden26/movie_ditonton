import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final ttvModel = TVModel(
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

  final ttv = TV(
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

  final ttvModelList = <TVModel>[ttvModel];
  final ttvList = <TV>[ttv];

  group('On Air TV Shows', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVOnTheAir())
              .thenAnswer((_) async => ttvModelList);
          // act
          final result = await repository.getTVOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTVOnTheAir());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, ttvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVOnTheAir())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTVOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTVOnTheAir());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVOnTheAir())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTVOnTheAir();
          // assert
          verify(mockRemoteDataSource.getTVOnTheAir());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular TV Shows', () {
    test('should return tv show list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTVs())
              .thenAnswer((_) async => ttvModelList);
          // act
          final result = await repository.getPopularTVs();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, ttvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTVs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTVs();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTVs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTVs();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated TV Shows', () {
    test('should return tv show list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTVs())
              .thenAnswer((_) async => ttvModelList);
          // act
          final result = await repository.getTopRatedTVs();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, ttvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTVs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTVs();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTVs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTVs();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TV Show Detail', () {
    final tId = 31917;
    final ttvResponse = TVDetailResponse(
      backdropPath: "/ypLoTftyF5EpGBxJas4PThIdiU4.jpg",
      episodeRunTime: [41],
      firstAirDate: "2010-06-08",
      genres: [GenreModel(id: 18,name:"Drama"), GenreModel(id: 9648, name: "Mystery")],
      homepage: "http://freeform.go.com/shows/pretty-little-liars",
      id: 31917,
      inProduction: false,
      languages: ["en"],
      lastAirDate: "2017-06-27",
      name: "Pretty Little Liars",
      numberOfEpisodes: 161,
      numberOfSeasons: 7,
      originalLanguage: "en",
      originalName: "Pretty Little Liars",
      overview: 'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
      popularity: 162.634,
      posterPath: "/aUPbHiLS3hCHKjtLsncFa9g0viV.jpg",
      seasons: [
        SeasonModel(airDate: "2012-08-28", episodeCount: 11, id: 43395, name: "Specials", overview: "", posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg", seasonNumber: 0),
        SeasonModel(airDate: "2010-06-08", episodeCount: 22, id: 43392, name: "Season 1", overview: "", posterPath: "/m4quKGjN9gt6SorPRqclVftPClW.jpg", seasonNumber: 1),
        SeasonModel(airDate: "2011-06-14", episodeCount: 25, id: 43393, name: "Season 2", overview: "Season two begins moments after the explosive season one finale and the girls are the talk of the town. Surprises and challenges will be in store for each, and \"A\" may succeed in her quest. Emily, Hanna, Spencer, and Aria are crumbling under the constant pressure of A's relentless texts and the knowledge that A inexplicably knows every little detail of their lives, including their thoughts, and is watching and anticipating the girls' every move. Spencer's family is falling apart. Aria and Ezra's relationship gets even more complicated, and Aria's brother Mike finds himself in trouble with the law, while their parents find themselves tested like never before.", posterPath: "/4BikyFpJ9LnSxDXhuZF5QMFtKdl.jpg", seasonNumber: 2),
        SeasonModel(airDate: "2012-06-05", episodeCount: 24, id: 43394, name: "Season 3", overview: "", posterPath: "/lSi1fFg21x2YMyAO49CmQTqK543.jpg", seasonNumber: 3),
        SeasonModel(airDate: "2013-06-11", episodeCount: 24, id: 43396, name: "Season 4", overview: "", posterPath: "/x67TIFqCnFLLtvHi2vfxKFi1gPj.jpg", seasonNumber: 4),
        SeasonModel(airDate: "2014-06-10", episodeCount: 26, id: 61066, name: "Season 5", overview: "", posterPath: "/7kwds7CnHqMeYwEwHkl5Lx0i1GH.jpg", seasonNumber: 5),
        SeasonModel(airDate: "2015-06-02", episodeCount: 20, id: 66519, name: "Season 6", overview: "The girls may have gotten out of the Dollhouse but what happened to them during their time of captivity has lasting effects. With worried loved ones watching over them, the PLLs are home and trying to heal, with not much success. Even with suspected tormentor Andrew in custody, Aria, Emily, Hanna and Spencer fear they are far from safe. Meanwhile, Alison must deal with her past indiscretions and her notoriety around Rosewood.", posterPath: "/qdvS6s5QRIx9lrgJLS29606vFmY.jpg", seasonNumber: 6),
        SeasonModel(airDate: "2016-06-21", episodeCount: 20, id: 76310, name: "Season 7", overview: "After Hanna's shocking abduction by \"Uber A\", the PLLs and company desperately race against the clock to save one of their own. The only way to do this is by handing over evidence of Charlotte's real murderer to \"Uber A\". In order to do so, the girls must decide what blatant lines they are willing to cross that they have never breached before; and once they cross that line, there is no turning back.", posterPath: "/xWEYL5vBzzsSwlwRXJpIBmMbjwJ.jpg", seasonNumber: 7),
      ],
      status: "Ended",
      tagline: "Time to bring your A game.",
      type: "Scripted",
      voteAverage: 8.029,
      voteCount: 2231,
    );

    test(
        'should return tv show data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVDetail(tId))
              .thenAnswer((_) async => ttvResponse);
          // act
          final result = await repository.getTVDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTVDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTVDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTVDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTVDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTVDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get TV Show Recommendations', () {
    final ttvList = <TVModel>[];
    final tId = 31917;

    test('should return data (tv show list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVRecommendations(tId))
              .thenAnswer((_) async => ttvList);
          // act
          final result = await repository.getTVRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTVRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(ttvList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTVRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTVRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTVRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTVRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTVRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach TV Shows', () {
    final tQuery = 'pretty';

    test('should return tv show list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTVs(tQuery))
              .thenAnswer((_) async => ttvModelList);
          // act
          final result = await repository.searchTVs(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, ttvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTVs(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTVs(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTVs(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTVs(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 31917;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv shows', () {
    test('should return list of tv shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });

  group('Get tv Show Season Detail', () {
    final tId = 31917;
    final tSeason = 0;
    final tSeasonResponse = SeasonDetailResponse(
      airDate: "2012-08-28",
      episodes: [
        EpisodeDetailResponse(airDate: "2012-08-28", episodeNumber: 1, id: 761960, name: "Pretty Dirty Secrets: A ReservAtion", overview: "Right after The Lady Killer, The camera is seen in the Halloween store. Looking at all the masks. The phone rings and we hear Shana's voice telling the caller she'll get back to them. Then \"A\"'s voice is heard calling for a costume order but before A says who they are the call ends.", productionCode: "", seasonNumber: 0, stillPath: "/AubQFiFMIyZdlcnEkGmEYxFYR9Y.jpg", voteAverage: 7.6, voteCount: 4),
        EpisodeDetailResponse(airDate: "2012-09-04", episodeNumber: 2, id: 761959, name: "Pretty Dirty Secrets: A Reunion", overview: "Jason meets CeCe", productionCode: "", seasonNumber: 0, stillPath: "/bU5Tm0WzoyMa2tFi5Bsto3i0KzT.jpg", voteAverage: 7.8, voteCount: 2),
        EpisodeDetailResponse(airDate: "2012-09-11", episodeNumber: 3, id: 761961, name: "Pretty Dirty Secrets: A VoicemAil", overview: "Someone gets a very mysterious voicemail", productionCode: "", seasonNumber: 0, stillPath: "/vaEqNSI6KMkFksMmOYV3rSIK30a.jpg", voteAverage: 5.8, voteCount: 2),
        EpisodeDetailResponse(airDate: "2012-09-18", episodeNumber: 4, id: 761962, name: "Pretty Dirty Secrets: I'm a Free MAn", overview: "You'll learn more about Rosewood's newest resident and watch a very tense face-off!", productionCode: "", seasonNumber: 0, stillPath: "/iaySZuHdZGAncDGe8tOsRxyzBQh.jpg", voteAverage: 4.2, voteCount: 3),
        EpisodeDetailResponse(airDate: "2012-09-25", episodeNumber: 5, id: 761963, name: "Pretty Dirty Secrets: TrAde Off", overview: "Lucas has a mysterious run-in with a very familiar face -- and he has something in common with the new girl in town.", productionCode: "", seasonNumber: 0, stillPath: "/gF8rD15uLE1SPXoJXMfj3ON3vD7.jpg", voteAverage: 8.0, voteCount: 2),
        EpisodeDetailResponse(airDate: "2012-10-02", episodeNumber: 6, id: 761964, name: "Pretty Dirty Secrets: AssociAtion", overview: "A mystery lurks around a new girl and her phone", productionCode: "", seasonNumber: 0, stillPath: "/vHzqQJk8OdCyk5uJbGSEV3L0p0i.jpg", voteAverage: 9.8, voteCount: 2),
        EpisodeDetailResponse(airDate: "2012-10-09", episodeNumber: 7, id: 761965, name: "Pretty Dirty Secrets: CAll Security", overview: "The lights go out in the Halloween store", productionCode: "", seasonNumber: 0, stillPath: "/4CM5qRPV3VEn1ksNizytvQq5nWQ.jpg", voteAverage: 6.8, voteCount: 2),
        EpisodeDetailResponse(airDate: "2012-10-16", episodeNumber: 8, id: 761966, name: "Pretty Dirty Secrets: The 'A' Train", overview: "\"A\" looks at a train map...", productionCode: "", seasonNumber: 0, stillPath: "/k2dfl7iRkRRuBfTjXDSBuqsCJWH.jpg", voteAverage: 7.2, voteCount: 2),
        EpisodeDetailResponse(airDate: "2013-06-04", episodeNumber: 9, id: 761967, name: "A LiArs Guide to Rosewood", overview: "Featuring new voice over from the all-seeing Mona, this special will recap the Liars history with “A” from the very first text message, to the most recent spotting of Red Coat.", productionCode: "", seasonNumber: 0, stillPath: "/kruCxBZqfg3x3VvUMYnUpY4sLAE.jpg", voteAverage: 6.8, voteCount: 3),
        EpisodeDetailResponse(airDate: "2015-11-24", episodeNumber: 10, id: 1140352, name: "5 Years Forward", overview: "A glimpse at what everyone’s favorite characters have been up to inside and outside of Rosewood over the past five years. The episode will feature never-before-seen scenes, backstage tours of brand new PLL sets, interviews with the cast and crew surrounding the highly anticipated time jump, including the style evolution of the Liars, and more.", productionCode: "2M7021", seasonNumber: 0, stillPath: "/m4RNFrHJl35vxjpJ4O20XSRzn4L.jpg", voteAverage: 0.0, voteCount: 0),
        EpisodeDetailResponse(airDate: "2017-06-27", episodeNumber: 11, id: 1329015, name: "Pretty Little Liars: A-List Wrap Party", overview: "Cast members Troian Bellisario, Ashley Benson, Lucy Hale, Shay Mitchell and Sasha Pieterse join series showrunner I. Marlene King for a revealing discussion of tightly held secrets, behind-the-scenes insights and memorable moments.", productionCode: "", seasonNumber: 0, stillPath: "/gVl2it4IYkPILkzzYZ2pMOe7FFb.jpg", voteAverage: 0.0, voteCount: 0),
      ],
      id: 43395,
      name: "Specials",
      overview: "",
      posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg",
      seasonNumber: 0,
    );

    test(
        'should return tv show data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
              .thenAnswer((_) async => tSeasonResponse);
          // act
          final result = await repository.getSeasonDetail(tId, tSeason);
          // assert
          verify(mockRemoteDataSource.getSeasonDetail(tId, tSeason));
          expect(result, equals(Right(testSeasonDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
              .thenThrow(ServerException());
          // act
          final result = await repository.getSeasonDetail(tId, tSeason);
          // assert
          verify(mockRemoteDataSource.getSeasonDetail(tId, tSeason));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getSeasonDetail(tId, tSeason);
          // assert
          verify(mockRemoteDataSource.getSeasonDetail(tId, tSeason));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });
}
