import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVs usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetPopularTVs(mockTVRepository);
  });

  final ttvs = <TV>[];

  group('GetPopularTVs Tests', () {
    group('execute', () {
      test(
          'should get list of tv shows from the repository when execute function is called',
              () async {
            // arrange
            when(mockTVRepository.getPopularTVs())
                .thenAnswer((_) async => Right(ttvs));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(ttvs));
          });
    });
  });
}
