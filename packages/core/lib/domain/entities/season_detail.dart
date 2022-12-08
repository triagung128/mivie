import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final int id;
  final String? airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const SeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props {
    return [
      id,
      airDate,
      episodes,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
