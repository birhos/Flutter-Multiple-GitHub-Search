import 'package:equatable/equatable.dart';

import 'package:example/listenable/search/searchResult.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {
  @override
  String toString() => 'SearchState | InitialSearchState';
}

class SearchLoadingState extends SearchState {
  @override
  String toString() => 'SearchState | SearchLoadingState';
}

class SearchEmptyState extends SearchState {
  @override
  String toString() => 'SearchState | SearchEmptyState';
}

class SearchLoadedState extends SearchState {
  final SearchResult result;

  const SearchLoadedState({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SearchState | SearchLoadedState';
}

class SearchErrorState extends SearchState {
  @override
  String toString() => 'SearchState | SearchErrorState';
}
