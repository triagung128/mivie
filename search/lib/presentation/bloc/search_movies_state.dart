part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object?> get props => [];
}

class SearchMoviesEmpty extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  SearchMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchMoviesHasData extends SearchMoviesState {
  final List<Movie> result;

  SearchMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
