part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  FetchDetailMovie(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}

class AddWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  AddWatchlistMovie(this.movieDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [movieDetail];
  // coverage:ignore-end
}

class RemoveFromWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  RemoveFromWatchlistMovie(this.movieDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [movieDetail];
  // coverage:ignore-end
}

class LoadWatchlistStatusMovie extends DetailMovieEvent {
  final int id;

  LoadWatchlistStatusMovie(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
