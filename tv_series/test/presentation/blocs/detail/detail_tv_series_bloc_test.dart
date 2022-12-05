import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTvSeries])
void main() {
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    detailTvSeriesBloc = DetailTvSeriesBloc(mockGetDetailTvSeries);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(detailTvSeriesBloc.state, DetailTvSeriesEmpty());
  });

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => const Right(tTvSeriesDetail));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvSeriesLoading(),
      const DetailTvSeriesHasData(tTvSeriesDetail),
    ],
    verify: (bloc) => verify(mockGetDetailTvSeries.execute(tId)),
  );

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'Should emit [Loading, Error] when get detail tv series is unsuccessful',
    build: () {
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvSeriesLoading(),
      const DetailTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetDetailTvSeries.execute(tId)),
  );
}
