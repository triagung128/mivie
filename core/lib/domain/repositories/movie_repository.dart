import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, List<Movie>>> search(String query);
  Future<Either<Failure, List<Movie>>> getWatchlist();
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<Movie>>> getRecommendation(int id);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
}
