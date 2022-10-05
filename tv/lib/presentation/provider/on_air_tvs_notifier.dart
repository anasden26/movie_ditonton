import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_on_air.dart';
import 'package:flutter/foundation.dart';

class OnAirtvsNotifier extends ChangeNotifier {
  final GetOnAirtvs getOnAirtvs;

  OnAirtvsNotifier(this.getOnAirtvs);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<tv> _tvs = [];
  List<tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirtvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnAirtvs.execute();

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
