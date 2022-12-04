part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;

  PopularMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
