import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailMovie {
  final MovieRepository repository;

  GetDetailMovie(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getDetail(id);
  }
}
