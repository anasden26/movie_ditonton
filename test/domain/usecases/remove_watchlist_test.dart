import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mocktvRepository = MocktvRepository();
    usecase = RemoveWatchlist(mockMovieRepository, mocktvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should remove watchlist tv shows from repository', () async {
    // arrange
    when(mocktvRepository.removeWatchlist(testtvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute2(testtvDetail);
    // assert
    verify(mocktvRepository.removeWatchlist(testtvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
