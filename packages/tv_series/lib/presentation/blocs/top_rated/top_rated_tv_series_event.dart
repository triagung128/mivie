part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesEvent extends Equatable {
  const TopRatedTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchTopRatedTvSeries extends TopRatedTvSeriesEvent {}
