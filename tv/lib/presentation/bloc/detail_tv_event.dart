part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent {
  const DetailTvEvent();
}

class fetchTvDetail extends DetailTvEvent {
  final int id;

  fetchTvDetail(this.id);
}