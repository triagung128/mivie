import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/blocs/top_rated/top_rated_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'Should emit [Loading, Error] when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      const TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
  );
}
