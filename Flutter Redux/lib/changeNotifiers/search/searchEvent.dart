import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchEvent {
  final String term;

  const SearchFetched({this.term});

  @override
  List<Object> get props => [term];

  @override
  String toString() => 'SearchEvent | SearchFetched';
}

class SearchStateReset extends SearchEvent {
  @override
  String toString() => 'SearchEvent | SearchStateReset';
}
