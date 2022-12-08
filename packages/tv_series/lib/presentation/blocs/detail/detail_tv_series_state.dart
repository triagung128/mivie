part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object?> get props => [];
}

class DetailTvSeriesEmpty extends DetailTvSeriesState {}

class DetailTvSeriesLoading extends DetailTvSeriesState {}

class DetailTvSeriesError extends DetailTvSeriesState {
  final String message;

  const DetailTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailTvSeriesHasData extends DetailTvSeriesState {
  final TvSeriesDetail result;

  const DetailTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
