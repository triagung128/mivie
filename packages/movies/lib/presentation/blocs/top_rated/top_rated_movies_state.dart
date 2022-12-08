part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> result;

  TopRatedMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
