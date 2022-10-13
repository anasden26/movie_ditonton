part of 'detail_bloc.dart';

abstract class DetailEvent {
  const DetailEvent();
}

class fetchMovieDetail extends DetailEvent {
  final int id;

  fetchMovieDetail(this.id);
}