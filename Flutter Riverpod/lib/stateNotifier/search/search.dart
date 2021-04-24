import 'package:common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../locator.dart';
import 'searchState.dart';

final searchProvider = StateNotifierProvider((ref) => SearchChangeNotifier());

class SearchChangeNotifier extends StateNotifier<SearchState> {
  SearchChangeNotifier() : super(InitialSearchState());

  final GithubRepository githubRepository = locator<GithubRepository>();

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
