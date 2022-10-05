import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlisttvNotifier extends ChangeNotifier {
  var _watchlisttvs = <tv>[];
  List<tv> get watchlisttvs => _watchlisttvs;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlisttvNotifier({required this.getWatchlisttvs});

  final GetWatchlisttvs getWatchlisttvs;

  Future<void> fetchWatchlisttvs() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlisttvs.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _watchlistState = RequestState.loaded;
        _watchlisttvs = tvsData;
        notifyListeners();
      },
    );
  }
}
