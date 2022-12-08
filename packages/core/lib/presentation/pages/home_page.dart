import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/movie_list_page.dart';
import 'package:tv_series/presentation/pages/tv_series_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.movie),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.live_tv_outlined),
      label: 'TV Series',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.remove_red_eye),
      label: 'Watchlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_outline),
      label: 'About',
    ),
  ];

  final List<Widget> _listWidget = [
    const MovieListPage(),
    const TvSeriesListPage(),
    const WatchlistPage(),
    const AboutPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kMikadoYellow,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
