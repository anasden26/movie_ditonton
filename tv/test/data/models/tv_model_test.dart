import 'package:tv/data/models/tv_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  final tTVModel = TVModel(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originalCountry: ['originalCountry'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTV = TV(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originalCountry: ['originalCountry'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTvTable = TVTable(
    id: 1,
    name: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });

  test('toJson from database helper', () {
    final result = tTvTable.toJson();
    final expectedJsonMap = {
      'id': 1,
      'name': "title",
      'posterPath': "posterPath",
      'overview': "overview",
    };
    expect(result, expectedJsonMap);
  });
}
