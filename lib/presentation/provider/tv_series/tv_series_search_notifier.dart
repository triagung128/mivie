import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier(this.searchTvSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
