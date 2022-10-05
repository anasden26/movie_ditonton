import 'dart:convert';
import 'dart:io';

import '../../../lib/data/datasources/tv_remote_data_source.dart';
import '../../../lib/data/models/season_detail_model.dart';
import '../../../lib/data/models/tv_detail_model.dart';
import '../../../lib/data/models/tv_response.dart';
import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../test/json_reader.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late tvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = tvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get tv On Air', () {
    final ttvList = tvResponse.fromJson(
        json.decode(readJson('dummy_data/on_air_tv.json')))
        .tvList;

    test('should return list of tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_air_tv.json'), 200));
          // act
          final result = await dataSource.gettvOnTheAir();
          // assert
          expect(result, equals(ttvList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.gettvOnTheAir();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular tv Shows', () {
    final ttvList =
        tvResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json')))
            .tvList;

    test('should return list of tv shows when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
          // act
          final result = await dataSource.getPopulartvs();
          // assert
          expect(result, ttvList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopulartvs();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated tv Shows', () {
    final ttvList = tvResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedtvs();
      // assert
      expect(result, ttvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedtvs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final tId = 31917;
    final ttvDetail = tvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_detail.json'), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      // act
      final result = await dataSource.gettvDetail(tId);
      // assert
      expect(result, equals(ttvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.gettvDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get movie recommendations', () {
    final ttvList = tvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 31917;

    test('should return list of tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
          // act
          final result = await dataSource.gettvRecommendations(tId);
          // assert
          expect(result, equals(ttvList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.gettvRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tv shows', () {
    final tSearchResult = tvResponse.fromJson(
        json.decode(readJson('dummy_data/search_tv_show.json')))
        .tvList;
    final tQuery = 'Pretty Little Liars';

    test('should return list of tv shows when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_tv_show.json'), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      // act
      final result = await dataSource.searchtvs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchtvs(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tv show season detail', () {
    final tId = 31917;
    final tSeason = 0;
    final tSeasonDetail = SeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/season_detail.json')));

    test('should return tv show season detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/season/$tSeason?$API_KEY')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/season_detail.json'), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      // act
      final result = await dataSource.getSeasonDetail(tId, tSeason);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/season/$tSeason?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getSeasonDetail(tId, tSeason);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
