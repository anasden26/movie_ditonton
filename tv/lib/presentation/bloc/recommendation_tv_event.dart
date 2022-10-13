part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent {
  const RecommendationTvEvent();
}

class OnLoadRecommendation extends RecommendationTvEvent {
  final int id;

  OnLoadRecommendation(this.id);
}