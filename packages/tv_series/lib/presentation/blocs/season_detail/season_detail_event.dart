part of 'season_detail_bloc.dart';

abstract class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchSeasonDetail extends SeasonDetailEvent {
  final int id;
  final int seasonNumber;

  const FetchSeasonDetail({
    required this.id,
    required this.seasonNumber,
  });
  // coverage:ignore-start
  @override
  List<Object?> get props => [id, seasonNumber];
  // coverage:ignore-end
}
