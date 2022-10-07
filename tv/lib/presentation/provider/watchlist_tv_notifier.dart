import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTVs = <TV>[];
  List<TV> get watchlistTVs => _watchlistTVs;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTVs});

  final GetWatchlistTVs getWatchlistTVs;

  Future<void> fetchWatchlistTVs() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTVs.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _watchlistState = RequestState.loaded;
        _watchlistTVs = tvsData;
        notifyListeners();
      },
    );
  }
}
