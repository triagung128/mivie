import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_detail_movie.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovie usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetDetailMovie(mockMovieRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testMovieDetail));
  });
}
