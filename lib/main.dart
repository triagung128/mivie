import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_series/now_playing_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:core/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movies/movie_list_notifier.dart';
import 'package:core/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/top_rated_tv_series_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:core/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case POPULAR_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIES_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchMoviesPage());
            case NOW_PLAYING_TV_SERIES_ROUTE:
              return MaterialPageRoute(
                builder: (_) => NowPlayingTvSeriesPage(),
              );
            case POPULAR_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case SEARCH_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => SearchTvSeriesPage());
            case TV_SERIES_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
