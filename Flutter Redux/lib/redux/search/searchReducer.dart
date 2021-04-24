import 'package:redux/redux.dart';

import 'searchState.dart';

final SearchState Function(SearchState, dynamic) searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, InitialSearchState>(_onInitial),
  TypedReducer<SearchState, SearchLoadingState>(_onLoading),
  TypedReducer<SearchState, SearchLoadedState>(_onLoaded),
  TypedReducer<SearchState, SearchEmptyState>(_onEmpty),
  TypedReducer<SearchState, SearchErrorState>(_onError),
]);

SearchState _onInitial(SearchState state, InitialSearchState action) {
  return InitialSearchState();
}

SearchState _onLoading(SearchState state, SearchLoadingState action) {
  return SearchLoadingState();
}

SearchState _onLoaded(SearchState state, SearchLoadedState action) {
  return SearchLoadedState(result: action.result);
}

SearchState _onEmpty(SearchState state, SearchEmptyState action) {
  return SearchEmptyState();
}

SearchState _onError(SearchState state, SearchErrorState action) {
  return SearchErrorState();
}
