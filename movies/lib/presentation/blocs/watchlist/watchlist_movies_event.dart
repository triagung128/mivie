part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistMovies extends WatchlistMoviesEvent {}
