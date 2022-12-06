part of 'season_detail_bloc.dart';

abstract class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object?> get props => [];
}

class SeasonDetailEmpty extends SeasonDetailState {}

class SeasonDetailLoading extends SeasonDetailState {}

class SeasonDetailHasData extends SeasonDetailState {
  final SeasonDetail result;

  const SeasonDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class SeasonDetailError extends SeasonDetailState {
  final String message;

  const SeasonDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
