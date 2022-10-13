import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/popular_bloc.dart';

void main() {
  late FakePopularBloc fakePopularBloc;

  setUpAll(() {
    fakePopularBloc = FakePopularBloc();
    registerFallbackValue(FakePopularSeriesEvent());
    registerFallbackValue(FakePopularSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularBloc>(
      create: (_) => fakePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakePopularBloc.state)
            .thenReturn(PopularLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakePopularBloc.state)
            .thenReturn(PopularHasData(<Movie>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakePopularBloc.state)
            .thenReturn(PopularError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakePopularBloc extends MockBloc<PopularEvent, PopularState> implements PopularBloc{}

class FakePopularSeriesEvent extends Fake implements PopularEvent {}

class FakePopularSeriesState extends Fake implements PopularState {}