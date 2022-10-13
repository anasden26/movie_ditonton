import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_detail_bloc.dart';

import '../../../../test/dummy_data/dummy_objects.dart';

void main() {
  late FakeDetailBloc fakeDetailBloc;
  late FakeWatchlistBloc fakeWatchlistBloc;
  late FakeRecommendBloc fakeRecommendBloc;

  setUpAll(() {
    fakeDetailBloc = FakeDetailBloc();
    registerFallbackValue(FakeDetailEvent());
    registerFallbackValue(FakeDetailState());

    fakeWatchlistBloc = FakeWatchlistBloc();
    registerFallbackValue(FakeWatchlistEvent());
    registerFallbackValue(FakeWatchlistState());

    fakeRecommendBloc = FakeRecommendBloc();
    registerFallbackValue(FakeRecommendEvent());
    registerFallbackValue(FakeRecommendState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailBloc>(
          create: (_) => fakeDetailBloc,
        ),
        BlocProvider<WatchlistDetailBloc>(
          create: (_) => fakeWatchlistBloc,
        ),
        BlocProvider<RecommendationBloc>(
          create: (_) => fakeRecommendBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailBloc.close();
    fakeWatchlistBloc.close();
    fakeRecommendBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display circular progress indicator when loading',
          (WidgetTester tester) async {
        when(() => fakeDetailBloc.state).thenReturn(DetailLoading());
        when(() => fakeWatchlistBloc.state).thenReturn(WatchlistDetailLoading());
        when(() => fakeRecommendBloc.state).thenReturn(RecommendationLoading());

        final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));
        await tester.pump();

        expect(circularProgressIndicatorFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeDetailBloc.state)
            .thenReturn(DetailError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailBloc.state)
            .thenReturn(DetailHasData(testMovieDetail, testMovieList));
        when(() => fakeWatchlistBloc.state).thenReturn(WatchlistDetailLoaded(false));
        final addIconFinder = find.byIcon(Icons.add);
        await tester
            .pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));
        await tester.pump();
        expect(addIconFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailBloc.state)
            .thenReturn(DetailHasData(testMovieDetail, testMovieList));
        when(() => fakeWatchlistBloc.state).thenReturn(WatchlistDetailLoaded(true));
        final checkIconFinder = find.byIcon(Icons.check);
        await tester
            .pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));
        await tester.pump();
        expect(checkIconFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailBloc.state)
            .thenReturn(DetailHasData(testMovieDetail, testMovieList));
        when(() => fakeWatchlistBloc.state).thenReturn(WatchlistDetailLoaded(false));
        when(() => fakeWatchlistBloc.state).thenReturn(WatchlistDetailMessage('Added to Watchlist'));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 31917)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets('Recommendation should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeRecommendBloc.state)
            .thenReturn(RecommendationHasData(testMovieList));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Recommendation should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeRecommendBloc.state)
            .thenReturn(RecommendationError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: testId)));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakeDetailEvent extends Fake implements DetailEvent {}

class FakeDetailState extends Fake implements DetailState {}

class FakeDetailBloc extends MockBloc<DetailEvent, DetailState> implements DetailBloc {}

class FakeWatchlistEvent extends Fake implements WatchlistDetailEvent {}

class FakeWatchlistState extends Fake implements WatchlistDetailState {}

class FakeWatchlistBloc extends MockBloc<WatchlistDetailEvent, WatchlistDetailState> implements WatchlistDetailBloc {}

class FakeRecommendEvent extends Fake implements RecommendationEvent {}

class FakeRecommendState extends Fake implements RecommendationState {}

class FakeRecommendBloc extends MockBloc<RecommendationEvent, RecommendationState> implements RecommendationBloc {}