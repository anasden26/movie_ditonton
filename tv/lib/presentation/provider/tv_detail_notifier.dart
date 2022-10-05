import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class tvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GettvDetail gettvDetail;
  final GettvRecommendations gettvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  tvDetailNotifier({
    required this.gettvDetail,
    required this.gettvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late tvDetail _tv;
  tvDetail get tvs => _tv;

  RequestState _tvState = RequestState.empty;
  RequestState get tvState => _tvState;

  List<tv> _tvRecommendations = [];
  List<tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchtvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();
    final detailResult = await gettvDetail.execute(id);
    final recommendationResult = await gettvRecommendations.execute(id);
    detailResult.fold(
          (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tv) {
        _recommendationState = RequestState.loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
              (tvs) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = tvs;
          },
        );
        _tvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(tvDetail tv) async {
    final result = await saveWatchlist.execute2(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(tvDetail tv) async {
    final result = await removeWatchlist.execute2(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute2(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
