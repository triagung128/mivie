import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesInitial()) {
    on<SearchMoviesOnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());

      final result = await _searchMovies.execute(query);
      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(SearchMoviesEmpty());
          } else {
            emit(SearchMoviesHasData(data));
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
