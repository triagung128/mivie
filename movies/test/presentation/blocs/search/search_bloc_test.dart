import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/blocs/search/search_movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchMoviesBloc.state, SearchMoviesInitial());
  });

  final tMovieList = <Movie>[testMovie];
  const tQuery = 'spiderman';

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(const SearchMoviesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(const SearchMoviesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesEmpty(),
    ],
    verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(const SearchMoviesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMoviesLoading(),
      const SearchMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
