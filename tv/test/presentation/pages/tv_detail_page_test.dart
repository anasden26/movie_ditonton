import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../../test/dummy_data/dummy_objects.dart';
import '../../../test/presentation/pages/tv_detail_page_test.mocks.dart';

@GenerateMocks([tvDetailNotifier])
void main() {
  late MocktvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MocktvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<tvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvs).thenReturn(testtvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(tvDetailPage(id: 31917)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvs).thenReturn(testtvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(tvDetailPage(id: 31917)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvs).thenReturn(testtvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(tvDetailPage(id: 31917)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvs).thenReturn(testtvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(tvDetailPage(id: 31917)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
