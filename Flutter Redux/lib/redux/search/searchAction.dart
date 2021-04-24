import 'package:equatable/equatable.dart';

abstract class SearchAction extends Equatable {
  const SearchAction();

  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchAction {
  final String term;

  const SearchFetched({required this.term});

  @override
  List<Object> get props => [term];
}

class SearchStateReset extends SearchAction {}
