import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesBloc
    extends Bloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState> {
  final GetRecommendationTvSeries _getRecommendationTvSeries;

  RecommendationTvSeriesBloc(this._getRecommendationTvSeries)
      : super(RecommendationTvSeriesEmpty()) {
    on<FetchRecommendationTvSeries>((event, emit) async {
      emit(RecommendationTvSeriesLoading());

      final id = event.id;
      final result = await _getRecommendationTvSeries.execute(id);

      result.fold(
        (failure) => emit(RecommendationTvSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(RecommendationTvSeriesEmpty());
          } else {
            emit(RecommendationTvSeriesHasData(data));
          }
        },
      );
    });
  }
}
