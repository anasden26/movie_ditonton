part of 'search_bloc_tv.dart';

abstract class SearchEventTV extends Equatable {
  const SearchEventTV();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchEventTV {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}