import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';

part 'watchlist_status_tv_series_event.dart';
part 'watchlist_status_tv_series_state.dart';

class WatchlistStatusTvSeriesBloc
    extends Bloc<WatchlistStatusTvSeriesEvent, WatchlistStatusTvSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  WatchlistStatusTvSeriesBloc({
    required this.getWatchListStatusTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: false, message: '')) {
    on<AddWatchlistTvSeries>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final id = tvSeriesDetail.id;

      final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);
      final status = await getWatchListStatusTvSeries.execute(id);

      result.fold(
        (failure) {
          emit(WatchlistStatusTvSeriesState(
            isAddedToWatchlist: status,
            message: failure.message,
          ));
        },
        (successMessage) {
          emit(WatchlistStatusTvSeriesState(
            isAddedToWatchlist: status,
            message: successMessage,
          ));
        },
      );
    });

    on<RemoveFromWatchlistTvSeries>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final id = tvSeriesDetail.id;

      final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);
      final status = await getWatchListStatusTvSeries.execute(id);

      result.fold(
        (failure) {
          emit(WatchlistStatusTvSeriesState(
            isAddedToWatchlist: status,
            message: failure.message,
          ));
        },
        (successMessage) {
          emit(WatchlistStatusTvSeriesState(
            isAddedToWatchlist: status,
            message: successMessage,
          ));
        },
      );
    });

    on<LoadWatchlistStatusTvSeries>((event, emit) async {
      final id = event.id;
      final status = await getWatchListStatusTvSeries.execute(id);

      emit(WatchlistStatusTvSeriesState(
        isAddedToWatchlist: status,
        message: '',
      ));
    });
  }
}
