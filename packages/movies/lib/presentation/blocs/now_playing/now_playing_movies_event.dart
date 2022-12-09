part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  const FetchNowPlayingMovies();

  @override
  List<Object> get props => [];
}
