import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTVs _popularTVs;

  PopularTvBloc(this._popularTVs) : super(PopularTvEmpty()) {
    on<fetchPopularTvs>((event, emit) async {

      emit(PopularTvLoading());
      final result = await _popularTVs.execute();

      result.fold(
            (failure) {
          emit(PopularTvError(failure.message));
        },
            (data) {
          emit(PopularTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}