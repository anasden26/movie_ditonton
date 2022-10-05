import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

class PopulartvsNotifier extends ChangeNotifier {
  final GetPopulartvs getPopulartvs;

  PopulartvsNotifier(this.getPopulartvs);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<tv> _tvs = [];
  List<tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopulartvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopulartvs.execute();

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
