import 'package:equatable/equatable.dart';

import 'package:common/common.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchEmptyState extends SearchState {}

class SearchLoadedState extends SearchState {
  final SearchResult result;

  const SearchLoadedState({required this.result});

  @override
  List<Object> get props => [result];
}

class SearchErrorState extends SearchState {}
