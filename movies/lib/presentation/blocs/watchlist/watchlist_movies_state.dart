part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  WatchlistMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
