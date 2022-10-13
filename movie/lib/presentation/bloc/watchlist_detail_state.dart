part of 'watchlist_detail_bloc.dart';

abstract class WatchlistDetailState extends Equatable {
  const WatchlistDetailState();

  @override
  List<Object> get props => [];
}

class WatchlistDetailEmpty extends WatchlistDetailState {}

class WatchlistDetailLoading extends WatchlistDetailState {}

class WatchlistDetailError extends WatchlistDetailState {
  final String message;

  WatchlistDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistDetailHasData extends WatchlistDetailState {
  final List<Movie> result;

  WatchlistDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistDetailLoaded extends WatchlistDetailState {
  final bool isAddedtoWatchlist;

  WatchlistDetailLoaded(this.isAddedtoWatchlist);

  @override
  List<Object> get props => [isAddedtoWatchlist];
}

class WatchlistDetailMessage extends WatchlistDetailState {
  final String message;

  WatchlistDetailMessage(this.message);

  @override
  List<Object> get props => [message];
}