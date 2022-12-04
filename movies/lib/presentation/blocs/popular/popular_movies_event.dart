part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPopularMovies extends PopularMoviesEvent {}
