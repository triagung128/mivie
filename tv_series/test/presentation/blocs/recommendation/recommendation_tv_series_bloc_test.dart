import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationTvSeries])
void main() {
  late RecommendationTvSeriesBloc recommendationTvSeriesBloc;
  late MockGetRecommendationTvSeries mockGetRecommendationTvSeries;

  setUp(() {
    mockGetRecommendationTvSeries = MockGetRecommendationTvSeries();
    recommendationTvSeriesBloc =
        RecommendationTvSeriesBloc(mockGetRecommendationTvSeries);
  });

  const tId = 1;
  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(recommendationTvSeriesBloc.state, RecommendationTvSeriesEmpty());
  });

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, Error] when get recommendations tv series is unsuccessful',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTvSeries(tId)),
    expect: () => [
      RecommendationTvSeriesLoading(),
      const RecommendationTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvSeries.execute(tId)),
  );
}
