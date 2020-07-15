import 'package:equatable/equatable.dart';

abstract class SearchAction extends Equatable {
  const SearchAction();

  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchAction {
  final String term;

  const SearchFetched({this.term});

  @override
  List<Object> get props => [term];

  @override
  String toString() => 'SearchAction | SearchFetched';
}

class SearchStateReset extends SearchAction {
  @override
  String toString() => 'SearchAction | SearchStateReset';
}
