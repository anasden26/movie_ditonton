import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GettvDetail usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GettvDetail(mocktvRepository);
  });

  final tId = 31917;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mocktvRepository.gettvDetail(tId))
        .thenAnswer((_) async => Right(testtvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testtvDetail));
  });
}
