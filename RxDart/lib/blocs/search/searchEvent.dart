import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchEvent {
  final String term;

  const SearchFetched({required this.term});

  @override
  List<Object> get props => [term];
}

class SearchStateReset extends SearchEvent {}
