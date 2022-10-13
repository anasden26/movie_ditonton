import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {

  final GetTVDetail _detail;
  final GetTVRecommendations _tvRecommendations;

  DetailTvBloc(this._detail, this._tvRecommendations) : super(DetailTvEmpty()) {
    on<fetchTvDetail>((event, emit) async {
      final id = event.id;

      emit(DetailTvLoading());
      final detailResult = await _detail.execute(id);
      final recommendationResult = await _tvRecommendations.execute(id);

      detailResult.fold(
            (failure) {
          emit(DetailTvError(failure.message));
        },
            (data) {
          recommendationResult.fold(
                (failure) {
              emit(DetailTvError(failure.message));
            },
                (movies) {
              emit(DetailTvHasData(data, movies));
            },
          );
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}