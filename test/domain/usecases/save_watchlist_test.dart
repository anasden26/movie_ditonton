import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mocktvRepository = MocktvRepository();
    usecase = SaveWatchlist(mockMovieRepository, mocktvRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test('should save tv shows to the repository', () async {
    // arrange
    when(mocktvRepository.saveWatchlist(testtvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute2(testtvDetail);
    // assert
    verify(mocktvRepository.saveWatchlist(testtvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
