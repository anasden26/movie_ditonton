import '../../../lib/data/models/tv_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/domain/entities/tv.dart';

void main() {
  final ttvModel = tvModel(
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

  final ttv = tv(
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

  test('should be a subclass of tv entity', () async {
    final result = ttvModel.toEntity();
    expect(result, ttv);
  });
}
