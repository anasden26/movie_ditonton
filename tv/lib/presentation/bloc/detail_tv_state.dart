part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTvEmpty extends DetailTvState {}

class DetailTvLoading extends DetailTvState {}

class DetailTvError extends DetailTvState {
  final String message;

  DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvHasData extends DetailTvState {
  final TVDetail result;
  final List<TV> recommendation;

  DetailTvHasData(this.result, this.recommendation);

  @override
  List<Object> get props => [result, recommendation];
}