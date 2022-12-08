part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable {
  const RecommendationTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchRecommendationTvSeries extends RecommendationTvSeriesEvent {
  final int id;

  const FetchRecommendationTvSeries(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
