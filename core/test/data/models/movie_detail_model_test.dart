import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 3.2,
    posterPath: 'posterPath',
    releaseDate: '2020-10-11',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'name')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2020-10-11',
    runtime: 1,
    title: 'title',
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tMovieDetailJson = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'genres': [
      {
        'id': 1,
        'name': 'name',
      }
    ],
    'homepage': 'homepage',
    'id': 1,
    'imdb_id': 'imdbId',
    'original_language': 'originalLanguage',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 3.2,
    'poster_path': 'posterPath',
    'release_date': '2020-10-11',
    'revenue': 1,
    'runtime': 1,
    'status': 'status',
    'tagline': 'tagline',
    'title': 'title',
    'video': true,
    'vote_average': 2.3,
    'vote_count': 1500,
  };

  test('should be a subclass of MovieDetail entity', () {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });

  test('should be a subclass of MovieDetail json', () {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
}
