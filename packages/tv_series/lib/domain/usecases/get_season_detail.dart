import 'package:core/core.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeasonDetail {
  final TvSeriesRepository repository;

  GetSeasonDetail(this.repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getSeasonDetail(id, seasonNumber);
  }
}
