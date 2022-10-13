import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:rxdart/rxdart.dart';
part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _watchlistMoviesPage;

  WatchlistBloc(this._watchlistMoviesPage) : super(WatchlistEmpty()) {
    on<OnLoad>((event, emit) async {

      emit(WatchlistLoading());
      final result = await _watchlistMoviesPage.execute();

      result.fold(
            (failure) {
          emit(WatchlistError(failure.message));
        },
            (data) {
          emit(WatchlistHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}