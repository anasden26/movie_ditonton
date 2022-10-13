part of 'top_rated_bloc.dart';

abstract class TopRatedEvent {
  const TopRatedEvent();
}

class fetchTopRatedMovies extends TopRatedEvent {}