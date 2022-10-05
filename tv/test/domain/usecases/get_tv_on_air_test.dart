import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirtvs usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = GetOnAirtvs(mocktvRepository);
  });

  final ttv = <tv>[];

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mocktvRepository.gettvOnTheAir())
        .thenAnswer((_) async => Right(ttv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(ttv));
  });
}
