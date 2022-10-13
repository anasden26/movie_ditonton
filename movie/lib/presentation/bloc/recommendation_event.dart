part of 'recommendation_bloc.dart';

abstract class RecommendationEvent {
  const RecommendationEvent();
}

class OnLoadRecommendation extends RecommendationEvent {
  final int id;

  OnLoadRecommendation(this.id);
}