part of 'watchlist_detail_tv_bloc.dart';

abstract class WatchlistDetailTvEvent {
  const WatchlistDetailTvEvent();
}

class CallWatchlist extends WatchlistDetailTvEvent {}

class AddWatchlist extends WatchlistDetailTvEvent {
  final TVDetail tvDetail;

  AddWatchlist(this.tvDetail);
}

class RemoveFromWatchlist extends WatchlistDetailTvEvent {
  final TVDetail tvDetail;

  RemoveFromWatchlist(this.tvDetail);
}

class LoadWatchlist extends WatchlistDetailTvEvent {
  final int id;

  LoadWatchlist(this.id);
}