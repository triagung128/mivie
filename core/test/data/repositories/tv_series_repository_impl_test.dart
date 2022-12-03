import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Get Now Playing TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlaying())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlaying();
      // assert
      verify(mockRemoteDataSource.getNowPlaying());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Get Popular TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopular();
      // assert
      verify(mockRemoteDataSource.getPopular());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular()).thenThrow(ServerException());
      // act
      final result = await repository.getPopular();
      // assert
      verify(mockRemoteDataSource.getPopular());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopular())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopular();
      // assert
      verify(mockRemoteDataSource.getPopular());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Get Top Rated TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRated();
      // assert
      verify(mockRemoteDataSource.getTopRated());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRated();
      // assert
      verify(mockRemoteDataSource.getTopRated());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRated())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRated();
      // assert
      verify(mockRemoteDataSource.getTopRated());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Get Search TV Series', () {
    final tQuery = 'game of thrones';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.search(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.search(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Detail TV Series', () {
    final tId = 1;

    test(
        'should return TV Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(result, equals(Right(tTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(mockRemoteDataSource.getDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Recommendations TV Series', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendation(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockRemoteDataSource.getRecommendation(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendation(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendation(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getRecommendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendation(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendation(tId);
      // assert
      verify(mockRemoteDataSource.getRecommendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Save Watchlist TV Series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist TV Series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(tTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(tTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(tTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(tTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getWatchlistById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get All Watchlist TV Series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [tTvSeriesTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistTvSeries]);
    });
  });
}
