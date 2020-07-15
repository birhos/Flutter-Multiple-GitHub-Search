import 'package:equatable/equatable.dart';

import 'package:example/redux/search/searchResult.dart';

abstract class SearchActionState extends Equatable {
  const SearchActionState();

  @override
  List<Object> get props => [];
}

class InitialSearchActionState extends SearchActionState {
  @override
  String toString() => 'SearchActionState | InitialSearchActionState';
}

class SearchLoadingActionState extends SearchActionState {
  @override
  String toString() => 'SearchActionState | SearchLoadingActionState';
}

class SearchEmptyActionState extends SearchActionState {
  @override
  String toString() => 'SearchActionState | SearchEmptyActionState';
}

class SearchLoadedActionState extends SearchActionState {
  final SearchResult result;

  const SearchLoadedActionState({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SearchActionState | SearchLoadedActionState';
}

class SearchErrorActionState extends SearchActionState {
  @override
  String toString() => 'SearchActionState | SearchErrorActionState';
}
