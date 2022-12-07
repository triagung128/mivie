import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/blocs/top_rated/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvSeriesBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  setUp(() {
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state)
        .thenReturn(const TopRatedTvSeriesHasData([tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state)
        .thenReturn(const TopRatedTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
