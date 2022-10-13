part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends DetailState {
  final MovieDetail result;
  final List<Movie> recommendation;

  DetailHasData(this.result, this.recommendation);

  @override
  List<Object> get props => [result, recommendation];
}