import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/blocs/watchlist/watchlist_movies_bloc.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

void main() {
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
  });

  setUp(() {
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>.value(
      value: mockWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state)
        .thenReturn(WatchlistMoviesEmpty());

    final textErrorBarFinder = find.text('Empty Watchlist');

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
