import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/top_rated_bloc.dart';

void main() {
  late FakeTopRatedBloc fakeTopRatedBloc;

  setUpAll(() {
    fakeTopRatedBloc = FakeTopRatedBloc();
    registerFallbackValue(FakeTopRatedSeriesEvent());
    registerFallbackValue(FakeTopRatedSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedBloc>(
      create: (_) => fakeTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => fakeTopRatedBloc.state)
            .thenReturn(TopRatedLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
        await tester.pump();

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => fakeTopRatedBloc.state)
            .thenReturn(TopRatedHasData(<Movie>[]));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when error',
          (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeTopRatedBloc.state)
            .thenReturn(TopRatedError(errorMessage));

        final textMessageKeyFinder = find.byKey(const Key('error_message'));
        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
        await tester.pump();

        expect(textMessageKeyFinder, findsOneWidget);
      });
}

class FakeTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState> implements TopRatedBloc{}

class FakeTopRatedSeriesEvent extends Fake implements TopRatedEvent {}

class FakeTopRatedSeriesState extends Fake implements TopRatedState {}