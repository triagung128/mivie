import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonDetailResponse extends Equatable {
  final int id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const SeasonDetailResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];

  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      airDate: airDate,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'air_date': airDate,
        'episodes': episodes.map((x) => x.toJson()).toList(),
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
      };

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponse(
        id: json['id'],
        airDate: json['air_date'],
        episodes: List<EpisodeModel>.from(
          json['episodes'].map((x) => EpisodeModel.fromJson(x)),
        ),
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );
}
