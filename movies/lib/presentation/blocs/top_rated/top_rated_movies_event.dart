part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchTopRatedMovies extends TopRatedMoviesEvent {}
