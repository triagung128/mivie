part of 'watchlist_status_tv_series_bloc.dart';

abstract class WatchlistStatusTvSeriesEvent extends Equatable {
  const WatchlistStatusTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class AddWatchlistTvSeries extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlistTvSeries(this.tvSeriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [tvSeriesDetail];
  // coverage:ignore-end
}

class RemoveFromWatchlistTvSeries extends WatchlistStatusTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveFromWatchlistTvSeries(this.tvSeriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [tvSeriesDetail];
  // coverage:ignore-end
}

class LoadWatchlistStatusTvSeries extends WatchlistStatusTvSeriesEvent {
  final int id;

  const LoadWatchlistStatusTvSeries(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
