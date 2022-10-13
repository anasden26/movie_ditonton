part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationEmpty extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationError extends RecommendationState {
  final String message;

  RecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationHasData extends RecommendationState {
  final List<Movie> result;

  RecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}