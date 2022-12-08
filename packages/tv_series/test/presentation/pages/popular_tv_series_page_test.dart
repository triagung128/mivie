import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/blocs/popular/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class FakePopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
  });

  setUp(() {
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenReturn(const PopularTvSeriesHasData([tTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvSeriesBloc.state)
        .thenReturn(const PopularTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
