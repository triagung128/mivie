part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();
}

class FetchTopRatedMovies extends TopRatedMoviesEvent {
  const FetchTopRatedMovies();

  @override
  List<Object> get props => [];
}
