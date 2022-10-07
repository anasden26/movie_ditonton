import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListStatus(mockMovieRepository, mockTVRepository);
  });

  group('Watchlist Status', () {
    test('should get watchlist status from watch repository', () async {
      // arrange
      when(mockMovieRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.execute(1);
      // assert
      expect(result, true);
    });
    test('should get watchlist status from tv repository', () async {
      // arrange
      when(mockTVRepository.isAddedToWatchlist(31917))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.execute2(31917);
      // assert
      expect(result, true);
    });
  });
}
