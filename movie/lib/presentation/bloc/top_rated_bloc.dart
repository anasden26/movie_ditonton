import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:rxdart/rxdart.dart';
part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedBloc(this._topRatedMovies) : super(TopRatedEmpty()) {
    on<fetchTopRatedMovies>((event, emit) async {

      emit(TopRatedLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
            (failure) {
          emit(TopRatedError(failure.message));
        },
            (data) {
          emit(TopRatedHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}