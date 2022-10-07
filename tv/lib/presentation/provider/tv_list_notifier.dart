import 'package:tv/domain/entities/tv.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';

class TVListNotifier extends ChangeNotifier {
  var _onAirTVs = <TV>[];
  List<TV> get onAirTVs => _onAirTVs;

  RequestState _onAirState = RequestState.empty;
  RequestState get onAirState => _onAirState;

  var _popularTVs = <TV>[];
  List<TV> get popularTVs => _popularTVs;

  RequestState _popularTVsState = RequestState.empty;
  RequestState get popularTVsState => _popularTVsState;

  var _topRatedTVs = <TV>[];
  List<TV> get topRatedTVs => _topRatedTVs;

  RequestState _topRatedTVsState = RequestState.empty;
  RequestState get topRatedTVsState => _topRatedTVsState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getOnAirTVs,
    required this.getPopularTVs,
    required this.getTopRatedTVs,
  });

  final GetOnAirTVs getOnAirTVs;
  final GetPopularTVs getPopularTVs;
  final GetTopRatedTVs getTopRatedTVs;

  Future<void> fetchOnAirTVs() async {
    _onAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTVs.execute();
    result.fold(
          (failure) {
        _onAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _onAirState = RequestState.loaded;
        _onAirTVs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVs() async {
    _popularTVsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTVs.execute();
    result.fold(
          (failure) {
        _popularTVsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _popularTVsState = RequestState.loaded;
        _popularTVs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTVs() async {
    _topRatedTVsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTVs.execute();
    result.fold(
          (failure) {
        _topRatedTVsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _topRatedTVsState = RequestState.loaded;
        _topRatedTVs = tvsData;
        notifyListeners();
      },
    );
  }
}
