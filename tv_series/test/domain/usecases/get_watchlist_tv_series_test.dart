import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriesList = [tTvSeries];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlist())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeriesList));
  });
}
