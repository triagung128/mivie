part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  FetchDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  AddWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  RemoveFromWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatusMovie extends DetailMovieEvent {
  final int id;

  LoadWatchlistStatusMovie(this.id);

  @override
  List<Object?> get props => [id];
}
