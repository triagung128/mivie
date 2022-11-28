import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail, GetTvSeriesRecommendations])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    provider = TvSeriesDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTvSeriesDetail = TvSeriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-10-10',
    genres: [Genre(id: 1, name: 'Drama')],
    id: 1,
    lastAirDate: '2022-10-10',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 3,
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: [
      Season(
        airDate: '2022-10-10',
        episodeCount: 15,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 10,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 8.3,
    voteCount: 1200,
  );

  final tTvSeries = TvSeries(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, tTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesRecommendationsState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesRecommendationsState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });
}
