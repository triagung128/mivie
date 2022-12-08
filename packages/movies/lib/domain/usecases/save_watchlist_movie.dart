import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistMovie {
  final MovieRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
