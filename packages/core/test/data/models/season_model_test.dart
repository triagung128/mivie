import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: '2020-10-10',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tSeason = Season(
    airDate: '2020-10-10',
    episodeCount: 12,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  const tSeasonJson = {
    'air_date': '2020-10-10',
    'episode_count': 12,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  test('should be a subclass of Season entity', () {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  test('should be a subclass of Season json', () {
    final result = tSeasonModel.toJson();
    expect(result, tSeasonJson);
  });
}
