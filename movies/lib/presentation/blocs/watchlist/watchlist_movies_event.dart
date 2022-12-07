part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchWatchlistMovies extends WatchlistMoviesEvent {}
