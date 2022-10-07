import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../../../test/json_reader.dart';

void main() {
  final tTVModel = TVModel(
      backdropPath:"/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg",
      firstAirDate:"2022-08-21",
      genreIds:[10765,18,10759],
      id:94997,
      name:"House of the Dragon",
      originalCountry:["US"],
      originalLanguage:"en",
      originalName:"House of the Dragon",
      overview:"The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity:5813.492,
      posterPath:"/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
      voteAverage:8.6,
      voteCount:1386
  );
  final tTVResponseModel =
  TVResponse(TVList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/on_air_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path":"/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg",
            "first_air_date":"2022-08-21",
            "genre_ids":[10765,18,10759],
            "id":94997,
            "name":"House of the Dragon",
            "origin_country":["US"],
            "original_language":"en",
            "original_name":"House of the Dragon",
            "overview":"The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "popularity":5813.492,
            "poster_path":"/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
            "vote_average":8.6,
            "vote_count":1386
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
