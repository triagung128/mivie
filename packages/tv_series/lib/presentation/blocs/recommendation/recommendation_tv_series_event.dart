part of 'recommendation_tv_series_bloc.dart';

abstract class RecommendationTvSeriesEvent extends Equatable {
  const RecommendationTvSeriesEvent();
}

class FetchRecommendationTvSeries extends RecommendationTvSeriesEvent {
  final int id;

  const FetchRecommendationTvSeries(this.id);

  @override
  List<Object?> get props => [id];
}
