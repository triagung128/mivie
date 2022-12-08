part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {}
