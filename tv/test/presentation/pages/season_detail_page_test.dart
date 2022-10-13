import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/season_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../../test/dummy_data/dummy_objects.dart';

void main() {
  late FakeSeasonDetailBloc fakeSeasonDetailBloc;

  setUp(() {
    fakeSeasonDetailBloc = FakeSeasonDetailBloc();
    registerFallbackValue(FakeSeasonDetailEvent());
    registerFallbackValue(FakeSeasonDetailState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailBlocTv>(
      create: (_) => fakeSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeSeasonDetailBloc.state).thenReturn(SeasonDetailLoadingTv());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(SeasonDetailPage(id: 1, season: 0)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
        const errorMessage = 'error message';

        when(() => fakeSeasonDetailBloc.state)
            .thenReturn(SeasonDetailErrorTv(errorMessage));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(SeasonDetailPage(id: 1, season: 0)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display list view when loaded',
          (WidgetTester tester) async {
            when(() => fakeSeasonDetailBloc.state)
                .thenReturn(SeasonDetailHasDataTv(testSeasonDetail));

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(SeasonDetailPage(id: 761960, season: 0)));

        expect(ListViewFinder, findsOneWidget);
      });
}

class FakeSeasonDetailEvent extends Fake implements SeasonDetailEventTv {}

class FakeSeasonDetailState extends Fake implements SeasonDetailStateTv {}

class FakeSeasonDetailBloc extends MockBloc<SeasonDetailEventTv, SeasonDetailStateTv> implements SeasonDetailBlocTv {}