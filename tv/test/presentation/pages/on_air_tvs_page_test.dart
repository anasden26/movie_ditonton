import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc.dart';
import 'package:tv/presentation/pages/on_air_tvs_page.dart';

void main() {
  late FakeOnAirTvBloc fakeOnAirTvBloc;

  setUpAll(() {
    fakeOnAirTvBloc = FakeOnAirTvBloc();
    registerFallbackValue(FakeOnAirTvSeriesEvent());
    registerFallbackValue(FakeOnAirTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvBloc>(
      create: (_) => fakeOnAirTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakeOnAirTvBloc.state)
            .thenReturn(OnAirTvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(OnAirTVsPage()));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeOnAirTvBloc.state)
            .thenReturn(OnAirTvHasData(<TV>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(OnAirTVsPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeOnAirTvBloc.state)
            .thenReturn(OnAirTvError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(OnAirTVsPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakeOnAirTvBloc extends MockBloc<OnAirTvEvent, OnAirTvState> implements OnAirTvBloc{}

class FakeOnAirTvSeriesEvent extends Fake implements OnAirTvEvent {}

class FakeOnAirTvSeriesState extends Fake implements OnAirTvState {}