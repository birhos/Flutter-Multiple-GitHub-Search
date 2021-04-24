import 'package:common/common.dart';
import 'package:get/state_manager.dart';

import '../../locator.dart';
import 'searchState.dart';

class SearchController extends GetxController {
  final GithubRepository githubRepository = locator<GithubRepository>();

  SearchState _state = InitialSearchState();

  SearchState get state => _state;

  set state(SearchState value) {
    _state = value;
    update();
  }

  Future<void> searchFetched(String term) async {
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

  void searchStateReset() {
    state = InitialSearchState();
  }
}
