import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationMovies {
  final MovieRepository repository;

  GetRecommendationMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getRecommendation(id);
  }
}
