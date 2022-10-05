import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late Searchtvs usecase;
  late MocktvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MocktvRepository();
    usecase = Searchtvs(mocktvRepository);
  });

  final ttv = <tv>[];
  final tQuery = 'Pretty Little Liars';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mocktvRepository.searchtvs(tQuery))
        .thenAnswer((_) async => Right(ttv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(ttv));
  });
}
