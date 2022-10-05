import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
part 'search_event_tv.dart';
part 'search_state_tv.dart';

class SearchBlocTV extends Bloc<SearchEventTV, SearchStateTV> {
  final Searchtvs _searchTvs;

  SearchBlocTV(this._searchTvs) : super(SearchEmptyTV()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoadingTV());
      final result = await _searchTvs.execute(query);

      result.fold(
            (failure) {
              emit(SearchErrorTV(failure.message));
            },
            (data) {
          emit(SearchHasDataTV(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}