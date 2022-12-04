part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
