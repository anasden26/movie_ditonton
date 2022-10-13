import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUpAll(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
            when(() => fakePopularTvBloc.state)
                .thenReturn(PopularTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTVsPage()));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
            when(() => fakePopularTvBloc.state)
                .thenReturn(PopularTvHasData(<TV>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularTVsPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakePopularTvBloc.state)
            .thenReturn(PopularTvError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(PopularTVsPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakePopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState> implements PopularTvBloc{}

class FakePopularTvSeriesEvent extends Fake implements PopularTvEvent {}

class FakePopularTvSeriesState extends Fake implements PopularTvState {}