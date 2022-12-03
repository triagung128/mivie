import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this._getWatchlistTvSeries)
      : super(WatchlistTvSeriesEmpty()) {
    on<FetchWatchlistTvSeries>((_, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await _getWatchlistTvSeries.execute();

      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(WatchlistTvSeriesEmpty());
          } else {
            emit(WatchlistTvSeriesHasData(data));
          }
        },
      );
    });
  }
}
