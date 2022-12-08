import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/blocs/search/search_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/search_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTvSeriesBloc
    extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

class FakeSearchTvSeriesEvent extends Fake implements SearchTvSeriesEvent {}

class FakeSearchTvSeriesState extends Fake implements SearchTvSeriesState {}

void main() {
  late MockSearchTvSeriesBloc mockSearchTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchTvSeriesEvent());
    registerFallbackValue(FakeSearchTvSeriesState());
  });

  setUp(() {
    mockSearchTvSeriesBloc = MockSearchTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvSeriesBloc>.value(
      value: mockSearchTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesHasData([tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesHasData([tTvSeries]));

    final formSearch = find.byType(TextField);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    await tester.enterText(formSearch, 'spiderman');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state).thenReturn(SearchTvSeriesEmpty());

    final textErrorBarFinder = find.text('Search Not Found');

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when initial', (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesInitial());

    final textErrorBarFinder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
