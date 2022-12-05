part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {}
