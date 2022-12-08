import 'dart:convert';

import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../utils/test_constants.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Now Playing TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/now_playing.json')))
        .tvSeriesList;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlaying();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlaying();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/popular.json')))
        .tvSeriesList;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/popular.json'), 200));
      // act
      final result = await dataSource.getPopular();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopular();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/top_rated.json')))
        .tvSeriesList;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRated();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRated();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search TV Series', () {
    final tSearchResult = TvSeriesResponse.fromJson(json.decode(
      readJson('dummy_data/tv_series/search_example_tv_series.json'),
    )).tvSeriesList;
    const tQuery = 'Game of Thrones';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(
        mockHttpClient
            .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')),
      ).thenAnswer(
        (_) async => http.Response(
            readJson('dummy_data/tv_series/search_example_tv_series.json'),
            200),
      );
      // act
      final result = await dataSource.search(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.search(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Series Detail', () {
    const tId = 1;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/tv_series_detail.json')));

    test('should return tv series detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getDetail(tId);
      // assert
      expect(result, equals(tTvSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Series Recommendations', () {
    final tMovieList = TvSeriesResponse.fromJson(json.decode(
            readJson('dummy_data/tv_series/tv_series_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of TV Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_recommendations.json'),
              200));
      // act
      final result = await dataSource.getRecommendation(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getRecommendation(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Season Detail', () {
    const tId = 1;
    const tSeasonNumber = 1;
    final tSeasonDetail = SeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/season_detail.json')));

    test('should return season detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/season_detail.json'), 200));
      // act
      final result = await dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
