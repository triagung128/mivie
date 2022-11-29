import 'package:core/core.dart';
import 'package:core/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:core/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = data.watchlistMovies[index];
                return CardList(
                  title: movie.title ?? '-',
                  overview: movie.overview ?? '-',
                  posterPath: '${movie.posterPath}',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MOVIE_DETAIL_ROUTE,
                      arguments: movie.id,
                    );
                  },
                );
              },
              itemCount: data.watchlistMovies.length,
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
