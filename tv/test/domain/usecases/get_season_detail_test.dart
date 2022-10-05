import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GetSeasonDetail(mocktvRepository);
  });

  final tId = 31917;
  final tSeason = 1;

  test('should get season tv show detail from the repository', () async {
    // arrange
    when(mocktvRepository.getSeasonDetail(tId, tSeason))
        .thenAnswer((_) async => Right(testSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeason);
    // assert
    expect(result, Right(testSeasonDetail));
  });
}
