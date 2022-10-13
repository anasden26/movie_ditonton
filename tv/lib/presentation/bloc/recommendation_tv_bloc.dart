import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTVRecommendations _tvRecommendations;

  RecommendationTvBloc(this._tvRecommendations) : super(RecommendationTvEmpty()) {
    on<OnLoadRecommendation>((event, emit) async {
      final id = event.id;

      emit(RecommendationTvLoading());
      final recommendationResult = await _tvRecommendations.execute(id);

      recommendationResult.fold(
              (failure) {
            emit(RecommendationTvError(failure.message));
          },
              (result) {
            emit(RecommendationTvHasData(result));
          }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}