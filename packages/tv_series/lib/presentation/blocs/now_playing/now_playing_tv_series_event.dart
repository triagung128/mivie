part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesEvent extends Equatable {
  const NowPlayingTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchNowPlayingTvSeries extends NowPlayingTvSeriesEvent {}
