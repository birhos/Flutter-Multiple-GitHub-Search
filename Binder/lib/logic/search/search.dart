import 'package:binder/binder.dart';
import 'package:common/common.dart';

import '../../locator.dart';
import 'searchState.dart';

final searchRef = StateRef<SearchState>(InitialSearchState());

final searchLogicRef = LogicRef((scope) => SearchLogic(scope));

class SearchLogic with Logic {
  @override
  final Scope scope;

  SearchLogic(this.scope);

  void changeState(SearchState s) {
    update(searchRef, (state) => s);
  }

  final GithubRepository githubRepository = locator<GithubRepository>();

  Future<void> searchFetched(String term) async {
    if (term.isEmpty) {
      changeState(InitialSearchState());
    } else {
      changeState(SearchLoadingState());

      try {
        SearchResult result = await githubRepository.search(term);
        if (result.isEmpty) {
          changeState(SearchEmptyState());
        } else {
          changeState(SearchLoadedState(result: result));
        }
      } catch (e) {
        changeState(SearchErrorState());
      }
    }
  }

  void searchStateReset() {
    changeState(InitialSearchState());
  }
}
