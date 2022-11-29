import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchListStatusTvSeries {
  final TvSeriesRepository repository;

  GetWatchListStatusTvSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
