import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:rxdart/rxdart.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {

  final GetMovieDetail _movieDetail;
  final GetMovieRecommendations _movieRecommendations;

  DetailBloc(this._movieDetail, this._movieRecommendations) : super(DetailEmpty()) {
    on<fetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());
      final detailResult = await _movieDetail.execute(id);
      final recommendationResult = await _movieRecommendations.execute(id);

      detailResult.fold(
        (failure) {
          emit(DetailError(failure.message));
        },
        (data) {
          recommendationResult.fold(
            (failure) {
              emit(DetailError(failure.message));
            },
            (movies) {
              emit(DetailHasData(data, movies));
            },
          );
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}