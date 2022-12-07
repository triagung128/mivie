part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class SearchTvSeriesOnQueryChanged extends SearchTvSeriesEvent {
  final String query;

  const SearchTvSeriesOnQueryChanged(this.query);
  // coverage:ignore-start
  @override
  List<Object?> get props => [query];
  // coverage:ignore-end
}
