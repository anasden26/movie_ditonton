import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';
import 'package:flutter/foundation.dart';

class OnAirTVsNotifier extends ChangeNotifier {
  final GetOnAirTVs getOnAirTVs;

  OnAirTVsNotifier(this.getOnAirTVs);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TV> _tvs = [];
  List<TV> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTVs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTVs.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
          (tvsData) {
        _tvs = tvsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
