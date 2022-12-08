import 'package:core/data/models/episode_model.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonDetailModel = SeasonDetailResponse(
    id: 1,
    airDate: '2020-10-10',
    episodes: [
      EpisodeModel(
        airDate: '2020-10-10',
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 8.3,
        voteCount: 1500,
      )
    ],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tSeasonDetail = SeasonDetail(
    id: 1,
    airDate: '2020-10-10',
    episodes: [
      Episode(
        airDate: '2020-10-10',
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 8.3,
        voteCount: 1500,
      )
    ],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tSeasonDetailJson = {
    'id': 1,
    'air_date': '2020-10-10',
    'episodes': [
      {
        'air_date': '2020-10-10',
        'episode_number': 1,
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'production_code': 'productionCode',
        'season_number': 1,
        'still_path': 'stillPath',
        'vote_average': 8.3,
        'vote_count': 1500,
      },
    ],
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  test('should be a subclass of SeasonDetail entity', () async {
    final result = tSeasonDetailModel.toEntity();
    expect(result, tSeasonDetail);
  });

  test('should be a subclass of SeasonDetail json', () async {
    final result = tSeasonDetailModel.toJson();
    expect(result, tSeasonDetailJson);
  });
}
