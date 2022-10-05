import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/foundation.dart';

class TopRatedtvsNotifier extends ChangeNotifier {
  final GetTopRatedtvs getTopRatedtvs;

  TopRatedtvsNotifier({required this.getTopRatedtvs});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<tv> _tvs = [];
  List<tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedtvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedtvs.execute();

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
