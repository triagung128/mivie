part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesEvent extends Equatable {
  const NowPlayingTvSeriesEvent();
}

class FetchNowPlayingTvSeries extends NowPlayingTvSeriesEvent {
  const FetchNowPlayingTvSeries();

  @override
  List<Object?> get props => [];
}
