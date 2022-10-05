import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GettvRecommendations usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GettvRecommendations(mocktvRepository);
  });

  final tId = 31917;
  final ttv = <tv>[];

  test('should get list of tv shows recommendations from the repository',
          () async {
        // arrange
        when(mocktvRepository.gettvRecommendations(tId))
            .thenAnswer((_) async => Right(ttv));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(ttv));
      });
}
