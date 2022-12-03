part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesEvent extends Equatable {
  const NowPlayingTvSeriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingTvSeries extends NowPlayingTvSeriesEvent {}
