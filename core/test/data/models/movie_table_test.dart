import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  const tMovieWatchlist = Movie.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  const tMovieTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a subclass of MovieTable entity', () async {
    final result = tMovieTable.toEntity();
    expect(result, tMovieWatchlist);
  });

  test('should be a subclass of MovieTable json', () async {
    final result = tMovieTable.toJson();
    expect(result, tMovieTableJson);
  });
}
