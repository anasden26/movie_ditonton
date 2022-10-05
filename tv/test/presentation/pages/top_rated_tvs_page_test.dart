import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:provider/provider.dart';

import '../../../test/presentation/pages/top_rated_tvs_page_test.mocks.dart';

@GenerateMocks([TopRatedtvsNotifier])
void main() {
  late MockTopRatedtvsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedtvsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedtvsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.loading);

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedtvsPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.loaded);
        when(mockNotifier.tvs).thenReturn(<tv>[]);

        final ListViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedtvsPage()));

        expect(ListViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.error);
        when(mockNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TopRatedtvsPage()));

        expect(textFinder, findsOneWidget);
      });
}
