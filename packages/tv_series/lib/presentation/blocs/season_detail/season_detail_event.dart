part of 'season_detail_bloc.dart';

abstract class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();
}

class FetchSeasonDetail extends SeasonDetailEvent {
  final int id;
  final int seasonNumber;

  const FetchSeasonDetail({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [id, seasonNumber];
}
