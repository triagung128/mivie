import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: '2020-11-10',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 8.3,
    voteCount: 1000,
  );

  const tEpisode = Episode(
    airDate: '2020-11-10',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 8.3,
    voteCount: 1000,
  );

  const tEpisodeJson = {
    'air_date': '2020-11-10',
    'episode_number': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'production_code': 'productionCode',
    'season_number': 1,
    'still_path': 'stillPath',
    'vote_average': 8.3,
    'vote_count': 1000,
  };

  test('should be a subclass of Episode entity', () {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });

  test('should be a subclass of Episode json', () {
    final result = tEpisodeModel.toJson();
    expect(result, tEpisodeJson);
  });
}
