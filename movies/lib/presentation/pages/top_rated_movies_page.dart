import 'package:core/core.dart';
import 'package:core/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
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
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
