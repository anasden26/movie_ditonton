part of 'watchlist_detail_tv_bloc.dart';

abstract class WatchlistDetailTvState extends Equatable {
  const WatchlistDetailTvState();

  @override
  List<Object> get props => [];
}

class WatchlistDetailTvEmpty extends WatchlistDetailTvState {}

class WatchlistDetailTvLoading extends WatchlistDetailTvState {}

class WatchlistDetailTvError extends WatchlistDetailTvState {
  final String message;

  WatchlistDetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistDetailTvHasData extends WatchlistDetailTvState {
  final List<TV> result;

  WatchlistDetailTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistDetailTvLoaded extends WatchlistDetailTvState {
  final bool isAddedtoWatchlist;

  WatchlistDetailTvLoaded(this.isAddedtoWatchlist);

  @override
  List<Object> get props => [isAddedtoWatchlist];
}

class WatchlistDetailTvMessage extends WatchlistDetailTvState {
  final String message;

  WatchlistDetailTvMessage(this.message);

  @override
  List<Object> get props => [message];
}