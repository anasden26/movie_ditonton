import 'dart:convert';
import 'package:core/core.dart';
import '../models/season_detail_model.dart';
import '../models/tv_detail_model.dart';
import '../models/tv_model.dart';
import '../models/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class tvRemoteDataSource {
  Future<List<tvModel>> gettvOnTheAir();
  Future<List<tvModel>> getPopulartvs();
  Future<List<tvModel>> getTopRatedtvs();
  Future<tvDetailResponse> gettvDetail(int id);
  Future<List<tvModel>> gettvRecommendations(int id);
  Future<List<tvModel>> searchtvs(String query);
  Future<SeasonDetailResponse> getSeasonDetail(int id, int season);
}

class tvRemoteDataSourceImpl implements tvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  tvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<tvModel>> gettvOnTheAir() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return tvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<tvDetailResponse> gettvDetail(int id) async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return tvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<tvModel>> gettvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return tvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<tvModel>> getPopulartvs() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return tvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<tvModel>> getTopRatedtvs() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return tvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<tvModel>> searchtvs(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return tvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailResponse> getSeasonDetail(int id, int season) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$season?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
