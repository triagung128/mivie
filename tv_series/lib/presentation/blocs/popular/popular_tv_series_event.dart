part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesEvent extends Equatable {
  const PopularTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchPopularTvSeries extends PopularTvSeriesEvent {}
