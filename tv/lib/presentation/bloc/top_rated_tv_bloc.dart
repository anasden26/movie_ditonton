import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTVs _TopRatedTVs;

  TopRatedTvBloc(this._TopRatedTVs) : super(TopRatedTvEmpty()) {
    on<fetchTopRatedTvs>((event, emit) async {

      emit(TopRatedTvLoading());
      final result = await _TopRatedTVs.execute();

      result.fold(
            (failure) {
          emit(TopRatedTvError(failure.message));
        },
            (data) {
          emit(TopRatedTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}