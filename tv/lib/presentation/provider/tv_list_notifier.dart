import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import '../../domain/usecases/get_tv_on_air.dart';

class tvListNotifier extends ChangeNotifier {
  var _onAirtvs = <tv>[];
  List<tv> get onAirtvs => _onAirtvs;

  RequestState _onAirState = RequestState.empty;
  RequestState get onAirState => _onAirState;

  var _populartvs = <tv>[];
  List<tv> get populartvs => _populartvs;

  RequestState _populartvsState = RequestState.empty;
  RequestState get populartvsState => _populartvsState;

  var _topRatedtvs = <tv>[];
  List<tv> get topRatedtvs => _topRatedtvs;

  RequestState _topRatedtvsState = RequestState.empty;
  RequestState get topRatedtvsState => _topRatedtvsState;

  String _message = '';
  String get message => _message;

  tvListNotifier({
    required this.getOnAirtvs,
    required this.getPopulartvs,
    required this.getTopRatedtvs,
  });

  final GetOnAirtvs getOnAirtvs;
  final GetPopulartvs getPopulartvs;
  final GetTopRatedtvs getTopRatedtvs;

  Future<void> fetchOnAirtvs() async {
    _onAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirtvs.execute();
    result.fold(
          (failure) {
        _onAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _onAirState = RequestState.loaded;
        _onAirtvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopulartvs() async {
    _populartvsState = RequestState.loading;
    notifyListeners();

    final result = await getPopulartvs.execute();
    result.fold(
          (failure) {
        _populartvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _populartvsState = RequestState.loaded;
        _populartvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedtvs() async {
    _topRatedtvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedtvs.execute();
    result.fold(
          (failure) {
        _topRatedtvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (tvsData) {
        _topRatedtvsState = RequestState.loaded;
        _topRatedtvs = tvsData;
        notifyListeners();
      },
    );
  }
}
