import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
part 'watchlist_detail_tv_event.dart';
part 'watchlist_detail_tv_state.dart';

class WatchlistDetailTvBloc extends Bloc<WatchlistDetailTvEvent, WatchlistDetailTvState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTVs _watchlistTVs;
  final GetWatchListStatus _watchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistDetailTvBloc(this._watchlistTVs, this._watchListStatus, this._saveWatchlist, this._removeWatchlist) : super(WatchlistDetailTvEmpty()) {
    on<CallWatchlist>((event, emit) async {
      emit(WatchlistDetailTvLoading());
      final result = await _watchlistTVs.execute();

      result.fold(
              (failure) => emit(WatchlistDetailTvError(failure.message)),
              (data) => data.isNotEmpty
              ? emit(WatchlistDetailTvHasData(data))
              : emit(
            WatchlistDetailTvEmpty(),
          )
      );
    });

    on<LoadWatchlist>((event, emit) async {
      final id = event.id;

      final result = await _watchListStatus.execute2(id);

      emit(WatchlistDetailTvLoaded(result));
    });

    on<AddWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      emit(WatchlistDetailTvLoading());
      final result = await _saveWatchlist.execute2(tv);

      await result.fold(
            (failure) async {
          emit(WatchlistDetailTvError(failure.message));
        },
            (successMessage) async {
          emit(WatchlistDetailTvMessage(successMessage));
        },
      );

      LoadWatchlist(tv.id);
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      emit(WatchlistDetailTvLoading());
      final result = await _removeWatchlist.execute2(tv);

      await result.fold(
            (failure) async {
          emit(WatchlistDetailTvError(failure.message));
        },
            (successMessage) async {
          emit(WatchlistDetailTvMessage(successMessage));
        },
      );

      LoadWatchlist(tv.id);
    });
  }
}