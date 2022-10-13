import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:rxdart/rxdart.dart';
part 'watchlist_detail_event.dart';
part 'watchlist_detail_state.dart';

class WatchlistDetailBloc extends Bloc<WatchlistDetailEvent, WatchlistDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _watchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistDetailBloc(this._getWatchlistMovies, this._watchListStatus, this._saveWatchlist, this._removeWatchlist) : super(WatchlistDetailEmpty()) {
    on<CallWatchlist>((event, emit) async {
      emit(WatchlistDetailLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistDetailError(failure.message)),
        (data) => data.isNotEmpty
          ? emit(WatchlistDetailHasData(data))
          : emit(
            WatchlistDetailEmpty(),
          )
      );
    });
    on<LoadWatchlist>((event, emit) async {
      final id = event.id;

      final result = await _watchListStatus.execute(id);

      emit(WatchlistDetailLoaded(result));
    });

    on<AddWatchlist>((event, emit) async {
      final mv = event.movie;

      emit(WatchlistDetailLoading());
      final result = await _saveWatchlist.execute(mv);

      await result.fold(
            (failure) async {
          emit(WatchlistDetailError(failure.message));
        },
            (successMessage) async {
          emit(WatchlistDetailMessage(successMessage));
        },
      );

      LoadWatchlist(mv.id);
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final mv = event.movie;

      emit(WatchlistDetailLoading());
      final result = await _removeWatchlist.execute(mv);

      await result.fold(
            (failure) async {
          emit(WatchlistDetailError(failure.message));
        },
            (successMessage) async {
          emit(WatchlistDetailMessage(successMessage));
        },
      );

      LoadWatchlist(mv.id);
    });
  }
}