import 'package:redux/redux.dart';

import 'package:example/redux/search/searchState.dart';
import 'package:example/redux/search/searchActionState.dart';

final Function searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, InitialSearchActionState>(_onInitial),
  TypedReducer<SearchState, SearchLoadingActionState>(_onLoading),
  TypedReducer<SearchState, SearchLoadedActionState>(_onLoaded),
  TypedReducer<SearchState, SearchEmptyActionState>(_onEmpty),
  TypedReducer<SearchState, SearchErrorActionState>(_onError),
]);

SearchState _onInitial(SearchState state, InitialSearchActionState action) {
  return InitialSearchState();
}

SearchState _onLoading(SearchState state, SearchLoadingActionState action) {
  return SearchLoadingState();
}

SearchState _onLoaded(SearchState state, SearchLoadedActionState action) {
  return SearchLoadedState(result: action.result);
}

SearchState _onEmpty(SearchState state, SearchEmptyActionState action) {
  return SearchEmptyState();
}

SearchState _onError(SearchState state, SearchErrorActionState action) {
  return SearchErrorState();
}
