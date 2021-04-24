import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';

import '../../locator.dart';
import 'searchEvent.dart';
import 'searchState.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GithubRepository githubRepository = locator<GithubRepository>();

  SearchBloc() : super(InitialSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchFetched) {
      yield* _mapSearchFetchedToState(event.term);
    } else if (event is SearchStateReset) {
      yield* _mapSearchStateResetToState();
    }
  }

  Stream<SearchState> _mapSearchFetchedToState(String term) async* {
    if (term.isEmpty) {
      yield InitialSearchState();
    } else {
      yield SearchLoadingState();

      try {
        final SearchResult result = await githubRepository.search(term);
        if (result.isEmpty) {
          yield SearchEmptyState();
        } else {
          yield SearchLoadedState(result: result);
        }
      } catch (e) {
        print(e);
        yield SearchErrorState();
      }
    }
  }

  Stream<SearchState> _mapSearchStateResetToState() async* {
    yield InitialSearchState();
  }
}
