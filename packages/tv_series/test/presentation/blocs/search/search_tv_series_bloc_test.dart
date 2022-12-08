import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';
import 'package:tv_series/presentation/blocs/search/search_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchTvSeriesBloc.state, SearchTvSeriesInitial());
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];
  const tQuery = 'spiderman';

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchTvSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchTvSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchTvSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      const SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
