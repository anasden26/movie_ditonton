part of 'search_bloc_tv.dart';

abstract class SearchStateTv extends Equatable {
  const SearchStateTv();

  @override
  List<Object> get props => [];
}

class SearchEmptyTv extends SearchStateTv {}

class SearchLoadingTv extends SearchStateTv {}

class SearchErrorTv extends SearchStateTv {
  final String message;

  SearchErrorTv(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataTv extends SearchStateTv {
  final List<TV> result;

  SearchHasDataTv(this.result);

  @override
  List<Object> get props => [result];
}