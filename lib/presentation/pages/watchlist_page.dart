import 'package:ditonton/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    Text('Movies'),
    Text('TV Series'),
  ];

  final List<Widget> _listWidget = [
    WatchlistMoviesPage(),
    WatchlistTvSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          labelPadding: EdgeInsets.all(16),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: _listTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _listWidget,
      ),
    );
  }
}
