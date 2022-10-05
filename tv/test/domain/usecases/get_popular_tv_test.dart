import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopulartvs usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GetPopulartvs(mocktvRepository);
  });

  final ttv = <tv>[];

  group('GetPopulartvs Tests', () {
    group('execute', () {
      test(
          'should get list of tv shows from the repository when execute function is called',
              () async {
            // arrange
            when(mocktvRepository.getPopulartvs())
                .thenAnswer((_) async => Right(ttv));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(ttv));
          });
    });
  });
}
