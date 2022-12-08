import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/blocs/season_detail/season_detail_bloc.dart';
import 'package:tv_series/presentation/pages/season_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeasonDetailBloc
    extends MockBloc<SeasonDetailEvent, SeasonDetailState>
    implements SeasonDetailBloc {}

class FakeSeasonDetailEvent extends Fake implements SeasonDetailEvent {}

class FakeSeasonDetailState extends Fake implements SeasonDetailState {}

void main() {
  late MockSeasonDetailBloc mockSeasonDetailBloc;

  setUpAll(() {
    registerFallbackValue(FakeSeasonDetailEvent());
    registerFallbackValue(FakeSeasonDetailState());
  });

  setUp(() {
    mockSeasonDetailBloc = MockSeasonDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailBloc>.value(
      value: mockSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;
  const tSeasonNumber = 1;

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state).thenReturn(SeasonDetailLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
      id: tId,
      seasonNumber: tSeasonNumber,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state)
        .thenReturn(const SeasonDetailHasData(tSeasonDetail));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(
      const SeasonDetailPage(id: tId, seasonNumber: tSeasonNumber),
    ));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailBloc.state)
        .thenReturn(const SeasonDetailError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(
      const SeasonDetailPage(id: tId, seasonNumber: tSeasonNumber),
    ));

    expect(textFinder, findsOneWidget);
  });
}
