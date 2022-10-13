import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:rxdart/rxdart.dart';
part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies _popularMovies;

  PopularBloc(this._popularMovies) : super(PopularEmpty()) {
    on<fetchPopularMovies>((event, emit) async {

      emit(PopularLoading());
      final result = await _popularMovies.execute();

      result.fold(
            (failure) {
          emit(PopularError(failure.message));
        },
            (data) {
          emit(PopularHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}