import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/blocs/season_detail/season_detail_bloc.dart';

class SeasonDetailPage extends StatefulWidget {
  final int id;
  final int seasonNumber;

  const SeasonDetailPage({
    required this.id,
    required this.seasonNumber,
    super.key,
  });

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SeasonDetailBloc>().add(FetchSeasonDetail(
            id: widget.id,
            seasonNumber: widget.seasonNumber,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
          builder: (_, state) {
            if (state is SeasonDetailHasData) {
              final season = state.result;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    style: kHeading6.copyWith(fontSize: 18),
                  ),
                  Text(
                    '${season.episodes.length} Episodes',
                    style: kSubtitle.copyWith(fontSize: 14),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        builder: (_, state) {
          if (state is SeasonDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailHasData) {
            final episodes = state.result.episodes;
            if (episodes.isEmpty) {
              return const Center(
                child: Text('No Episodes'),
              );
            } else {
              return ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (_, index) {
                  final episode = episodes[index];
                  return EpisodeCardList(episode: episode);
                },
              );
            }
          } else if (state is SeasonDetailError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Error Get Season'),
            );
          }
        },
      ),
    );
  }
}

class EpisodeCardList extends StatelessWidget {
  final Episode episode;

  const EpisodeCardList({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    width: 120,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: episode.stillPath != null
                        ? '$baseImageUrl${episode.stillPath}'
                        : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Text('Error Image'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Episode ${episode.episodeNumber}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        episode.name,
                        style: kHeading6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
            child: Text(
              episode.overview,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
