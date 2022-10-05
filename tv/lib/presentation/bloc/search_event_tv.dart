part of 'search_bloc_tv.dart';

abstract class SearchEventTV extends Equatable {
  const SearchEventTV();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTV extends SearchEventTV {
  final String query;

  OnQueryChangedTV(this.query);

  @override
  List<Object> get props => [query];
}