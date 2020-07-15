import 'package:scoped_model/scoped_model.dart';

import 'package:example/locator.dart';
import 'package:example/resources/dataHandler.dart';
import 'package:example/listenable/search/searchState.dart';
import 'package:example/listenable/search/searchEvent.dart';
import 'package:example/listenable/search/searchResult.dart';

class SearchListenable extends Model {
  final GithubRepository githubRepository = locator<GithubRepository>();

  SearchState _state;

  SearchListenable() {
    _state = InitialSearchState();
  }

  SearchState get state => _state;

  set state(SearchState value) {
    _state = value;
    notifyListeners();
  }

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
        SearchResult result = await githubRepository.search(term);
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
