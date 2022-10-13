import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:rxdart/rxdart.dart';
part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final GetMovieRecommendations _movieRecommendations;

  RecommendationBloc(this._movieRecommendations) : super(RecommendationEmpty()) {
    on<OnLoadRecommendation>((event, emit) async {
      final id = event.id;

      emit(RecommendationLoading());
      final recommendationResult = await _movieRecommendations.execute(id);

      recommendationResult.fold(
              (failure) {
            emit(RecommendationError(failure.message));
          },
              (result) {
            emit(RecommendationHasData(result));
          }
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}