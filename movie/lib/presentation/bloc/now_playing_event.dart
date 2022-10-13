part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent {
  const NowPlayingEvent();
}

class fetchNowPlayingMovies extends NowPlayingEvent {}