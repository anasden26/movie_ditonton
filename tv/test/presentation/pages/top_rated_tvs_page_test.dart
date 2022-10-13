import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';

void main() {
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUpAll(() {
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => fakeTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakeTopRatedTvBloc.state)
            .thenReturn(TopRatedTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeTopRatedTvBloc.state)
            .thenReturn(TopRatedTvHasData(<TV>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeTopRatedTvBloc.state)
            .thenReturn(TopRatedTvError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakeTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState> implements TopRatedTvBloc{}

class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvEvent {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvState {}