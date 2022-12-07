part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchPopularMovies extends PopularMoviesEvent {}
