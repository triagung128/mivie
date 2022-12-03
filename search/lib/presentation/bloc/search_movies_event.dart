part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object?> get props => [];
}

class SearchMoviesOnQueryChanged extends SearchMoviesEvent {
  final String query;

  SearchMoviesOnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
