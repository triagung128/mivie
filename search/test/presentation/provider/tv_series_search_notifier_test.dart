import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSeriesSearchNotifier(mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    popularity: 29.780826,
    id: 1399,
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    voteAverage: 7.91,
    overview:
        'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
    firstAirDate: '2011-04-17',
    originCountry: ['US'],
    genreIds: [10765, 10759, 18],
    originalLanguage: 'en',
    voteCount: 1172,
    name: 'Game of Thrones',
    originalName: 'Game of Thrones',
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];
  final tQuery = 'game of thrones';

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
