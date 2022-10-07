import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
part 'search_event_tv.dart';
part 'search_state_tv.dart';

class SearchBlocTv extends Bloc<SearchEventTv, SearchStateTv> {
  final SearchTVs _searchtvs;

  SearchBlocTv(this._searchtvs) : super(SearchEmptyTv()) {
    on<OnQueryChangedTv>((event, emit) async {
      final query = event.query;

      emit(SearchLoadingTv());
      final result = await _searchtvs.execute(query);

      result.fold(
            (failure) {
              emit(SearchErrorTv(failure.message));
            },
            (data) {
          emit(SearchHasDataTv(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}