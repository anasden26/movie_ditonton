part of 'search_bloc_tv.dart';

abstract class SearchStateTV extends Equatable {
  const SearchStateTV();

  @override
  List<Object> get props => [];
}

class SearchEmptyTV extends SearchStateTV {}

class SearchLoadingTV extends SearchStateTV {}

class SearchErrorTV extends SearchStateTV {
  final String message;

  SearchErrorTV(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataTV extends SearchStateTV {
  final List<tv> result;

  SearchHasDataTV(this.result);

  @override
  List<Object> get props => [result];
}