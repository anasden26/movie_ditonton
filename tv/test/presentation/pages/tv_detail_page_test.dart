import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_detail_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../../../test/dummy_data/dummy_objects.dart';

void main() {
  late FakeTvDetailBloc fakeTvDetailBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;
  late FakeTvRecommendBloc fakeTvRecommendBloc;

  setUpAll(() {
    fakeTvDetailBloc = FakeTvDetailBloc();
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());

    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());

    fakeTvRecommendBloc = FakeTvRecommendBloc();
    registerFallbackValue(FakeTvRecommendEvent());
    registerFallbackValue(FakeTvRecommendState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(
          create: (_) => fakeTvDetailBloc,
        ),
        BlocProvider<WatchlistDetailTvBloc>(
          create: (_) => fakeWatchlistTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => fakeTvRecommendBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvDetailBloc.close();
    fakeWatchlistTvBloc.close();
    fakeTvRecommendBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display circular progress indicator when loading',
          (WidgetTester tester) async {
        when(() => fakeTvDetailBloc.state).thenReturn(DetailTvLoading());
        when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistDetailTvLoading());
        when(() => fakeTvRecommendBloc.state).thenReturn(RecommendationTvLoading());

        final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));
        await tester.pump();

        expect(circularProgressIndicatorFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeTvDetailBloc.state)
            .thenReturn(DetailTvError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeTvDetailBloc.state)
            .thenReturn(DetailTvHasData(testTvDetail, <TV>[]));
        when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistDetailTvLoaded(false));
        final addIconFinder = find.byIcon(Icons.add);
        await tester
            .pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));
        await tester.pump();
        expect(addIconFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeTvDetailBloc.state)
            .thenReturn(DetailTvHasData(testTvDetail, <TV>[]));
        when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistDetailTvLoaded(true));
        final checkIconFinder = find.byIcon(Icons.check);
        await tester
            .pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));
        await tester.pump();
        expect(checkIconFinder, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeTvDetailBloc.state)
            .thenReturn(DetailTvHasData(testTvDetail, <TV>[]));
        when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistDetailTvLoaded(false));
        when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistDetailTvMessage('Added to Watchlist'));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 31917)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets('Recommendation should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeTvRecommendBloc.state)
            .thenReturn(RecommendationTvHasData(<TV>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Recommendation should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeTvRecommendBloc.state)
            .thenReturn(RecommendationTvError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: testId)));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakeTvDetailEvent extends Fake implements DetailTvEvent {}

class FakeTvDetailState extends Fake implements DetailTvState {}

class FakeTvDetailBloc extends MockBloc<DetailTvEvent, DetailTvState> implements DetailTvBloc {}

class FakeWatchlistTvEvent extends Fake implements WatchlistDetailTvEvent {}

class FakeWatchlistTvState extends Fake implements WatchlistDetailTvState {}

class FakeWatchlistTvBloc extends MockBloc<WatchlistDetailTvEvent, WatchlistDetailTvState> implements WatchlistDetailTvBloc {}

class FakeTvRecommendEvent extends Fake implements RecommendationTvEvent {}

class FakeTvRecommendState extends Fake implements RecommendationTvState {}

class FakeTvRecommendBloc extends MockBloc<RecommendationTvEvent, RecommendationTvState> implements RecommendationTvBloc {}