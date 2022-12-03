import 'package:core/core.dart';
import 'package:core/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/blocs/now_playing/now_playing_tv_series_bloc.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  const NowPlayingTvSeriesPage({super.key});

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingTvSeriesBloc>().add(FetchNowPlayingTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return CardList(
                    title: tvSeries.name ?? '-',
                    overview: tvSeries.overview ?? '-',
                    posterPath: '${tvSeries.posterPath}',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TV_SERIES_DETAIL_ROUTE,
                        arguments: tvSeries.id,
                      );
                    },
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Now Playing TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
