part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {
  const FetchWatchlistTvSeries();

  @override
  List<Object?> get props => [];
}
