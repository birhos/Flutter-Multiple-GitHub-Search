import 'package:mobx/mobx.dart';

import 'package:example/locator.dart';
import 'package:example/resources/dataHandler.dart';
import 'package:example/store/search/searchEvent.dart';
import 'package:example/store/search/searchResult.dart';
import 'package:example/store/search/searchState.dart';

part 'searchStore.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final GithubRepository githubRepository = locator<GithubRepository>();

  @observable
  SearchState state;

  _SearchStore() {
    state = InitialSearchState();
  }

  @action
  void mapEventToState(SearchEvent event) {
    if (event is SearchFetched) {
      _mapSearchFetchedToState(event.term);
    } else if (event is SearchStateReset) {
      _mapSearchStateResetToState();
    }
  }

  void _mapSearchFetchedToState(String term) async {
    if (term.isEmpty) {
      state = InitialSearchState();
    } else {
      state = SearchLoadingState();

      try {
        final SearchResult result = await githubRepository.search(term);
        if (result.isEmpty) {
          state = SearchEmptyState();
        } else {
          state = SearchLoadedState(result: result);
        }
      } catch (e) {
        state = SearchErrorState();
      }
    }
  }

  void _mapSearchStateResetToState() async {
    state = InitialSearchState();
  }
}
