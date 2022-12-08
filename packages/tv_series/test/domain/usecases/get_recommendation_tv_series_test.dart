import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendationTvSeries(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.getRecommendation(tId))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
