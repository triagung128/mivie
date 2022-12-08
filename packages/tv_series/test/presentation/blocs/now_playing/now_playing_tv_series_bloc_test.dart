import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/blocs/now_playing/now_playing_tv_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
  });

  final tTvSeriesList = <TvSeries>[tTvSeries];

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, Error] when get now playing tv series is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      const NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
  );
}
