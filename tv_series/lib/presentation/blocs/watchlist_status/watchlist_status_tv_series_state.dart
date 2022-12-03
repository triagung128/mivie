part of 'watchlist_status_tv_series_bloc.dart';

class WatchlistStatusTvSeriesState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const WatchlistStatusTvSeriesState({
    required this.isAddedToWatchlist,
    required this.message,
  });

  @override
  List<Object?> get props => [isAddedToWatchlist, message];
}
