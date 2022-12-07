import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final String? airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  const EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_number': episodeNumber,
        'id': id,
        'name': name,
        'overview': overview,
        'production_code': productionCode,
        'season_number': seasonNumber,
        'still_path': stillPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        productionCode: json['production_code'],
        seasonNumber: json['season_number'],
        stillPath: json['still_path'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Episode toEntity() {
    return Episode(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
