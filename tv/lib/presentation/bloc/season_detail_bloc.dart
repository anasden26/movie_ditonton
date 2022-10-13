import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBlocTv extends Bloc<SeasonDetailEventTv, SeasonDetailStateTv> {
  final GetSeasonDetail _seasonDetail;

  SeasonDetailBlocTv(this._seasonDetail) : super(SeasonDetailEmptyTv()) {
    on<fetchSeasonDetail>((event, emit) async {
      final id = event.id;
      final season = event.season;

      emit(SeasonDetailLoadingTv());
      final result = await _seasonDetail.execute(id, season);

      await result.fold(
            (failure) async {
          emit(SeasonDetailErrorTv(failure.message));
        },
            (data) async {
          emit(SeasonDetailHasDataTv(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}