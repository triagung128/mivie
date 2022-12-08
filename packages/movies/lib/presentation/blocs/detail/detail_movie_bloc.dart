import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_detail_movie.dart';
import 'package:movies/domain/usecases/get_recommendation_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movies/domain/usecases/remove_watchlist_movie.dart';
import 'package:movies/domain/usecases/save_watchlist_movie.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailMovie getDetailMovie;
  final GetRecommendationMovies getRecommendationMovies;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;
  final GetWatchListStatusMovie getWatchListStatusMovie;

  DetailMovieBloc({
    required this.getDetailMovie,
    required this.getRecommendationMovies,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
    required this.getWatchListStatusMovie,
  }) : super(DetailMovieState.initial()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.loading));

      final id = event.id;

      final detailMovieResult = await getDetailMovie.execute(id);
      final recommendationMoviesResult =
          await getRecommendationMovies.execute(id);

      detailMovieResult.fold(
        (failure) => emit(
          state.copyWith(
            movieDetailState: RequestState.error,
            message: failure.message,
          ),
        ),
        (movieDetail) {
          emit(
            state.copyWith(
              movieRecommendationsState: RequestState.loading,
              movieDetailState: RequestState.loaded,
              movieDetail: movieDetail,
            ),
          );
          recommendationMoviesResult.fold(
            (failure) => emit(
              state.copyWith(
                movieRecommendationsState: RequestState.error,
                message: failure.message,
              ),
            ),
            (movieRecommendations) {
              if (movieRecommendations.isEmpty) {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.loaded,
                    movieRecommendations: movieRecommendations,
                  ),
                );
              }
            },
          );
        },
      );
    });

    on<AddWatchlistMovie>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await saveWatchlistMovie.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatusMovie(movieDetail.id));
    });

    on<RemoveFromWatchlistMovie>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlistMovie.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatusMovie(movieDetail.id));
    });

    on<LoadWatchlistStatusMovie>((event, emit) async {
      final status = await getWatchListStatusMovie.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: status));
    });
  }
}
