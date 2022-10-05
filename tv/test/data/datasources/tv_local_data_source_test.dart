import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late tvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = tvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlisttv(testtvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertWatchlist(testtvTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlisttv(testtvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlist(testtvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlisttv(testtvTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeWatchlist(testtvTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlisttv(testtvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlist(testtvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get tv Show Detail By Id', () {
    final tId = 31917;

    test('should return tv Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.gettvById(tId))
          .thenAnswer((_) async => testtvMap);
      // act
      final result = await dataSource.gettvById(tId);
      // assert
      expect(result, testtvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.gettvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.gettvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tvs', () {
    test('should return list of tvTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlisttv())
          .thenAnswer((_) async => [testtvMap]);
      // act
      final result = await dataSource.getWatchlisttv();
      // assert
      expect(result, [testtvTable]);
    });
  });
}
