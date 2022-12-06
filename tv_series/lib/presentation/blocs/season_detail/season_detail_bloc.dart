import 'package:core/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_season_detail.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailBloc(this.getSeasonDetail) : super(SeasonDetailEmpty()) {
    on<FetchSeasonDetail>((event, emit) async {
      emit(SeasonDetailLoading());

      final result = await getSeasonDetail.execute(
        event.id,
        event.seasonNumber,
      );

      result.fold(
        (failure) => emit(SeasonDetailError(failure.message)),
        (data) => emit(SeasonDetailHasData(data)),
      );
    });
  }
}
