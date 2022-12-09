part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  const FetchDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlistMovie extends DetailMovieEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlistMovie(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatusMovie extends DetailMovieEvent {
  final int id;

  const LoadWatchlistStatusMovie(this.id);

  @override
  List<Object?> get props => [id];
}
