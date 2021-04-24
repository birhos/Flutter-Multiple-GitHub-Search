import 'package:common/common.dart';
import 'package:mobx/mobx.dart';

import '../../locator.dart';
import 'searchState.dart';

part 'searchStore.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final GithubRepository githubRepository = locator<GithubRepository>();

  @observable
  SearchState state = InitialSearchState();

  @action
  Future<void> searchFetched(String term) async {
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

  @action
  void searchStateReset() {
    state = InitialSearchState();
  }
}
