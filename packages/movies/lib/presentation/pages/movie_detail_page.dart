import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/detail/detail_movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(FetchDetailMovie(widget.id));
      context.read<DetailMovieBloc>().add(LoadWatchlistStatusMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        body: BlocConsumer<DetailMovieBloc, DetailMovieState>(
          listener: (context, state) {
            final message = state.watchlistMessage;
            if (message == DetailMovieBloc.watchlistAddSuccessMessage ||
                message == DetailMovieBloc.watchlistRemoveSuccessMessage) {
              _scaffoldMessengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Text(message),
                  );
                },
              );
            }
          },
          listenWhen: (oldState, newState) {
            return oldState.watchlistMessage != newState.watchlistMessage &&
                newState.watchlistMessage != '';
          },
          builder: (_, state) {
            final movieDetailState = state.movieDetailState;
            if (movieDetailState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (movieDetailState == RequestState.loaded) {
              return SafeArea(
                child: DetailContent(
                  state.movieDetail!,
                  state.movieRecommendations,
                  state.isAddedToWatchlist,
                ),
              );
            } else if (movieDetailState == RequestState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movieDetail;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
    this.movieDetail,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${movieDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    movieDetail.title,
                                    style: kHeading5.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  key: const Key('watchlistButton'),
                                  onPressed: () {
                                    if (!isAddedWatchlist) {
                                      context
                                          .read<DetailMovieBloc>()
                                          .add(AddWatchlistMovie(movieDetail));
                                    } else {
                                      context
                                          .read<DetailMovieBloc>()
                                          .add(RemoveFromWatchlistMovie(
                                            movieDetail,
                                          ));
                                    }
                                  },
                                  icon: isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  label: const Text('Watchlist'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(_showDuration(movieDetail.runtime)),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${movieDetail.voteAverage.toStringAsFixed(1)} (IMDb)',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 0,
                              thickness: 0.2,
                              color: Color(0xFF515151),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Release date',
                                      style: kHeading6,
                                    ),
                                    Text(
                                      _showReleaseDate(movieDetail.releaseDate),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 47),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Genre',
                                        style: kHeading6,
                                      ),
                                      Text(_showGenres(movieDetail.genres)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 0,
                              thickness: 0.2,
                              color: Color(0xFF515151),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movieDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 0,
                              thickness: 0.2,
                              color: Color(0xFF515151),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<DetailMovieBloc, DetailMovieState>(
                              builder: (context, state) {
                                final recommendationsState =
                                    state.movieRecommendationsState;
                                if (recommendationsState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (recommendationsState ==
                                    RequestState.loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];

                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                movieDetailRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$baseImageUrl${movie.posterPath}',
                                                placeholder: (_, __) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (_, __, ___) =>
                                                    const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else if (recommendationsState ==
                                    RequestState.error) {
                                  return Text(state.message);
                                } else {
                                  return const Text('No Recommendations');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('iconBack'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';

    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '$hours hours $minutes minutes';
    } else {
      return '$minutes minutes';
    }
  }

  String _showReleaseDate(String releaseDate) {
    List<String> dateSplit = releaseDate.split('-');

    final String year = dateSplit[0];
    final String month = dateSplit[1];
    final String date = dateSplit[2];

    var monthName = month;

    switch (month) {
      case '01':
        monthName = 'January';
        break;
      case '02':
        monthName = 'February';
        break;
      case '03':
        monthName = 'March';
        break;
      case '04':
        monthName = 'April';
        break;
      case '05':
        monthName = 'May';
        break;
      case '06':
        monthName = 'June';
        break;
      case '07':
        monthName = 'July';
        break;
      case '08':
        monthName = 'August';
        break;
      case '09':
        monthName = 'September';
        break;
      case '10':
        monthName = 'October';
        break;
      case '11':
        monthName = 'November';
        break;
      case '12':
        monthName = 'December';
        break;
      default:
        monthName = '-';
    }

    return '$monthName $date, $year';
  }
}
