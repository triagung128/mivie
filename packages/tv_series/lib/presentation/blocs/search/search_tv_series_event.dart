part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
}

class SearchTvSeriesOnQueryChanged extends SearchTvSeriesEvent {
  final String query;

  const SearchTvSeriesOnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
