import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTopRatedTVs(mockTVRepository);
  });

  final ttv = <TV>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTVs())
        .thenAnswer((_) async => Right(ttv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(ttv));
  });
}
