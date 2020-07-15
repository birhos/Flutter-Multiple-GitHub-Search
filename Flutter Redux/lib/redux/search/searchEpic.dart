import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:example/locator.dart';
import 'package:example/resources/dataHandler.dart';
import 'package:example/redux/search/searchState.dart';
import 'package:example/redux/search/searchResult.dart';
import 'package:example/redux/search/searchAction.dart';
import 'package:example/redux/search/searchActionState.dart';

class SearchEpic implements EpicClass<SearchState> {
  final GithubRepository githubRepository = locator<GithubRepository>();

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<SearchState> store) {
    return actions
        .whereType<SearchAction>()
        .debounce((_) => TimerStream(true, Duration(milliseconds: 250)))
        .switchMap((action) => mapEventToState(action));
  }

  Stream<SearchActionState> mapEventToState(SearchAction event) async* {
    if (event is SearchFetched) {
      yield* _mapSearchFetchedToActionState(event.term);
    } else if (event is SearchStateReset) {
      yield* _mapSearchStateResetToActionState();
    }
  }

  Stream<SearchActionState> _mapSearchFetchedToActionState(String term) async* {
    if (term.isEmpty) {
      yield InitialSearchActionState();
    } else {
      yield SearchLoadingActionState();

      try {
        final SearchResult result = await githubRepository.search(term);
        if (result.isEmpty) {
          yield SearchEmptyActionState();
        } else {
          yield SearchLoadedActionState(result: result);
        }
      } catch (e) {
        yield SearchErrorActionState();
      }
    }
  }

  Stream<SearchActionState> _mapSearchStateResetToActionState() async* {
    yield InitialSearchActionState();
  }
}
