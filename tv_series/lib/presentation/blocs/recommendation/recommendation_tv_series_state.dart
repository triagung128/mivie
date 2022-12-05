part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesState extends Equatable {
  const RecommendationTvSeriesState();

  @override
  List<Object?> get props => [];
}

class RecommendationTvSeriesEmpty extends RecommendationTvSeriesState {}

class RecommendationTvSeriesLoading extends RecommendationTvSeriesState {}

class RecommendationTvSeriesError extends RecommendationTvSeriesState {
  final String message;

  const RecommendationTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationTvSeriesHasData extends RecommendationTvSeriesState {
  final List<TvSeries> result;

  const RecommendationTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
