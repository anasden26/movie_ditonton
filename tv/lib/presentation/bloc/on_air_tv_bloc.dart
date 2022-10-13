import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_on_air.dart';
part 'on_air_tv_event.dart';
part 'on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTVs _OnAirTVs;

  OnAirTvBloc(this._OnAirTVs) : super(OnAirTvEmpty()) {
    on<fetchOnAirTvs>((event, emit) async {

      emit(OnAirTvLoading());
      final result = await _OnAirTVs.execute();

      result.fold(
            (failure) {
          emit(OnAirTvError(failure.message));
        },
            (data) {
          emit(OnAirTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}