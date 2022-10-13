part of 'watchlist_detail_bloc.dart';

abstract class WatchlistDetailEvent extends Equatable {
  const WatchlistDetailEvent();
}

class CallWatchlist extends WatchlistDetailEvent {
  @override
  List<Object?> get props => [];
}

class AddWatchlist extends WatchlistDetailEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchlist extends WatchlistDetailEvent {
  final MovieDetail movie;

  RemoveFromWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class LoadWatchlist extends WatchlistDetailEvent {
  final int id;

  LoadWatchlist(this.id);

  @override
  List<Object?> get props => [id];
}