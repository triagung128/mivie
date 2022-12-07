import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/watchlist_status/watchlist_status_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTvSeriesBloc
    extends MockBloc<DetailTvSeriesEvent, DetailTvSeriesState>
    implements DetailTvSeriesBloc {}

class FakeDetailTvSeriesEvent extends Fake implements DetailTvSeriesEvent {}

class FakeDetailTvSeriesState extends Fake implements DetailTvSeriesState {}

class MockRecommendationTvSeriesBloc
    extends MockBloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState>
    implements RecommendationTvSeriesBloc {}

class FakeRecommendationTvSeriesEvent extends Fake
    implements RecommendationTvSeriesEvent {}

class FakeRecommendationTvSeriesState extends Fake
    implements RecommendationTvSeriesState {}

class MockWatchlistStatusTvSeriesBloc
    extends MockBloc<WatchlistStatusTvSeriesEvent, WatchlistStatusTvSeriesState>
    implements WatchlistStatusTvSeriesBloc {}

class FakeWatchlistStatusTvSeriesEvent extends Fake
    implements WatchlistStatusTvSeriesEvent {}

class FakeWatchlistStatusTvSeriesState extends Fake
    implements WatchlistStatusTvSeriesState {}

void main() {
  late MockDetailTvSeriesBloc mockDetailTvSeriesBloc;
  late MockRecommendationTvSeriesBloc mockRecommendationTvSeriesBloc;
  late MockWatchlistStatusTvSeriesBloc mockWatchlistStatusTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailTvSeriesEvent());
    registerFallbackValue(FakeDetailTvSeriesState());
    registerFallbackValue(FakeRecommendationTvSeriesEvent());
    registerFallbackValue(FakeRecommendationTvSeriesState());
    registerFallbackValue(FakeWatchlistStatusTvSeriesEvent());
    registerFallbackValue(FakeWatchlistStatusTvSeriesState());
  });

  setUp(() {
    mockDetailTvSeriesBloc = MockDetailTvSeriesBloc();
    mockRecommendationTvSeriesBloc = MockRecommendationTvSeriesBloc();
    mockWatchlistStatusTvSeriesBloc = MockWatchlistStatusTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesBloc>.value(value: mockDetailTvSeriesBloc),
        BlocProvider<RecommendationTvSeriesBloc>.value(
          value: mockRecommendationTvSeriesBloc,
        ),
        BlocProvider<WatchlistStatusTvSeriesBloc>.value(
          value: mockWatchlistStatusTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesHasData([tTvSeries]));
    when(() => mockWatchlistStatusTvSeriesBloc.state).thenReturn(
        const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: false, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesHasData([tTvSeries]));
    when(() => mockWatchlistStatusTvSeriesBloc.state).thenReturn(
        const WatchlistStatusTvSeriesState(
            isAddedToWatchlist: true, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesHasData([tTvSeries]));

    whenListen(
      mockWatchlistStatusTvSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusTvSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesHasData([tTvSeries]));

    whenListen(
      mockWatchlistStatusTvSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusTvSeriesState(
        isAddedToWatchlist: true,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Removed from Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesHasData([tTvSeries]));

    whenListen(
      mockWatchlistStatusTvSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: 'Failed Add to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusTvSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final alertDialog = find.byType(AlertDialog);
    final textMessage = find.text('Failed Add to Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(alertDialog, findsNothing);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(alertDialog, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets('TV Series should display message error when no internet network',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state).thenReturn(
        const DetailTvSeriesError('Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets(
    'Recommendations TV Series should display text when data is empty',
    (WidgetTester tester) async {
      when(() => mockDetailTvSeriesBloc.state)
          .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
      when(() => mockRecommendationTvSeriesBloc.state)
          .thenReturn(RecommendationTvSeriesEmpty());
      when(() => mockWatchlistStatusTvSeriesBloc.state).thenReturn(
        const WatchlistStatusTvSeriesState(
          isAddedToWatchlist: false,
          message: '',
        ),
      );

      final textErrorBarFinder = find.text('No Recommendations');

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

      expect(textErrorBarFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Recommendations TV Series should display message error when error',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state)
        .thenReturn(const DetailTvSeriesHasData(tTvSeriesDetail));
    when(() => mockRecommendationTvSeriesBloc.state)
        .thenReturn(const RecommendationTvSeriesError('Error'));
    when(() => mockWatchlistStatusTvSeriesBloc.state).thenReturn(
      const WatchlistStatusTvSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final textErrorBarFinder = find.text('Error');

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
