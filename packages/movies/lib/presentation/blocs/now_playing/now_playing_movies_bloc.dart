import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(NowPlayingMoviesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(NowPlayingMoviesEmpty());
          } else {
            emit(NowPlayingMoviesHasData(data));
          }
        },
      );
    });
  }
}
