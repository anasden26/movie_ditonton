import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailNotifier({
    required this.getSeasonDetail,
  });

  late SeasonDetail _season;
  SeasonDetail get season => _season;

  RequestState _seasonState = RequestState.empty;
  RequestState get seasonState => _seasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail(int id, int season) async {
    _seasonState = RequestState.loading;
    notifyListeners();
    final detailResult = await getSeasonDetail.execute(id, season);
    detailResult.fold(
          (failure) {
        _seasonState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
          (season) {
        _seasonState = RequestState.loaded;
        _season = season;
        notifyListeners();
      },
    );
  }
}
