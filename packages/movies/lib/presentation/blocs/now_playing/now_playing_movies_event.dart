part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {}
