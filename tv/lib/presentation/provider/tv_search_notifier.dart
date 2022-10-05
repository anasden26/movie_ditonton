import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/search_tvs.dart';

class tvSearchNotifier extends ChangeNotifier {
  final Searchtvs searchtvs;

  tvSearchNotifier({required this.searchtvs});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<tv> _searchResult = [];
  List<tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchtvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchtvs.execute(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
