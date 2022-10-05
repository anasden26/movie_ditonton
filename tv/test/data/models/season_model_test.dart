import 'package:tv/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/season.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: "2012-08-28",
    episodeCount: 11,
    id: 43395,
    name: "Specials",
    overview: "",
    posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg",
    seasonNumber: 0,
  );

  final tSeason = Season(
    airDate: "2012-08-28",
    episodeCount: 11,
    id: 43395,
    name: "Specials",
    overview: "",
    posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg",
    seasonNumber: 0,
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
