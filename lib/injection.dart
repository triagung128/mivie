import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movies/movie_list_notifier.dart';
import 'package:core/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/presentation/bloc/search_movies_bloc.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/now_playing/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/popular/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/search/search_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/watchlist/watchlist_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/watchlist_status/watchlist_status_tv_series_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(() => NowPlayingTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationTvSeriesBloc(locator()));
  locator.registerFactory(
    () => WatchlistStatusTvSeriesBloc(
      getWatchListStatusTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
      saveWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));

  // provider movies
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // use case tv series
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
