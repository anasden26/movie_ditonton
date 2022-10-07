part of 'search_bloc_tv.dart';

abstract class SearchEventTv {
  const SearchEventTv();
}

class OnQueryChangedTv extends SearchEventTv {
  final String query;

  OnQueryChangedTv(this.query);
}