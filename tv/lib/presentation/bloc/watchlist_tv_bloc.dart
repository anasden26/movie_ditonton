import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTVs _watchlistTVs;

  WatchlistTvBloc(this._watchlistTVs) : super(WatchlistTvEmpty()) {
    on<OnLoadTv>((event, emit) async {

      emit(WatchlistTvLoading());
      final result = await _watchlistTVs.execute();

      result.fold(
            (failure) {
          emit(WatchlistTvError(failure.message));
        },
            (data) {
          emit(WatchlistTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}