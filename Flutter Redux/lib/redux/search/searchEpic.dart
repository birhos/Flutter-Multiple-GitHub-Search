import 'dart:async';

import 'package:common/common.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../../locator.dart';
import 'searchAction.dart';
import 'searchState.dart';

class SearchEpic implements EpicClass<SearchState> {
  final GithubRepository githubRepository = locator<GithubRepository>();

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<SearchState> store) {
    return actions
        .whereType<SearchAction>()
        .debounce((_) => TimerStream(true, Duration(milliseconds: 250)))
        .switchMap((action) => mapEventToState(action));
  }

  Stream<SearchState> mapEventToState(SearchAction event) async* {
    if (event is SearchFetched) {
      yield* _mapSearchFetchedToActionState(event.term);
    } else if (event is SearchStateReset) {
      yield* _mapSearchStateResetToActionState();
    }
  }

  Stream<SearchState> _mapSearchFetchedToActionState(String term) async* {
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
        yield SearchErrorState();
      }
    }
  }

  Stream<SearchState> _mapSearchStateResetToActionState() async* {
    yield InitialSearchState();
  }
}
