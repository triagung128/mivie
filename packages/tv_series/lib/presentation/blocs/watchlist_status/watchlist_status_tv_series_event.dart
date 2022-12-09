part of 'watchlist_status_tv_series_bloc.dart';

abstract class WatchlistStatusTvSeriesEvent extends Equatable {
  const WatchlistStatusTvSeriesEvent();
}

class AddWatchlistTvSeries extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveFromWatchlistTvSeries extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveFromWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class LoadWatchlistStatusTvSeries extends WatchlistStatusTvSeriesEvent {
  final int id;

  const LoadWatchlistStatusTvSeries(this.id);

  @override
  List<Object?> get props => [id];
}
