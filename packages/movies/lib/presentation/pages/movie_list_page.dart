import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Movies',
                style: kHeading5.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, searchMoviesRoute);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFF211F30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16).copyWith(right: 20),
                        child: const Icon(Icons.search),
                      ),
                      Text(
                        'Sherlock Holmes',
                        style: kBodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0xFFBBBBBB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Now Playing',
                        style: kHeading6,
                      ),
                      BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                        builder: (_, state) {
                          if (state is NowPlayingMoviesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is NowPlayingMoviesHasData) {
                            return MovieList(
                              state.result,
                              key: const PageStorageKey<String>(
                                  'listMovieNowPlaying'),
                            );
                          } else if (state is NowPlayingMoviesError) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else {
                            return const Center(
                              child: Text('Failed'),
                            );
                          }
                        },
                      ),
                      _buildSubHeading(
                        title: 'Popular',
                        onTap: () =>
                            Navigator.pushNamed(context, popularMoviesRoute),
                      ),
                      BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                        builder: (_, state) {
                          if (state is PopularMoviesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is PopularMoviesHasData) {
                            return MovieList(
                              state.result,
                              key: const PageStorageKey<String>(
                                  'listMoviePopular'),
                            );
                          } else if (state is PopularMoviesError) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else {
                            return const Center(
                              child: Text('Failed'),
                            );
                          }
                        },
                      ),
                      _buildSubHeading(
                        title: 'Top Rated',
                        onTap: () =>
                            Navigator.pushNamed(context, topRatedMoviesRoute),
                      ),
                      BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                        builder: (_, state) {
                          if (state is TopRatedMoviesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is TopRatedMoviesHasData) {
                            return MovieList(
                              state.result,
                              key: const PageStorageKey<String>(
                                  'listMovieTopRated'),
                            );
                          } else if (state is TopRatedMoviesError) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else {
                            return const Center(
                              child: Text('Failed'),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              key: const Key('movieItem'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
