import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlisttvs usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GetWatchlisttvs(mocktvRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mocktvRepository.getWatchlisttv())
        .thenAnswer((_) async => Right(testtvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testtvList));
  });
}
