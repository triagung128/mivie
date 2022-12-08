part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class SearchMoviesOnQueryChanged extends SearchMoviesEvent {
  final String query;

  const SearchMoviesOnQueryChanged(this.query);
  // coverage:ignore-start
  @override
  List<Object?> get props => [query];
  // coverage:ignore-end
}
