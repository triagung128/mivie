import 'package:core/domain/repositories/movie_repository.dart';

class GetWatchListStatusMovie {
  final MovieRepository repository;

  GetWatchListStatusMovie(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
