part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
}

class SearchMoviesOnQueryChanged extends SearchMoviesEvent {
  final String query;

  const SearchMoviesOnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
