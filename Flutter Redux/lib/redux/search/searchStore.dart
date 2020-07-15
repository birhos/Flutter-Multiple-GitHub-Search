import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'package:example/redux/search/searchEpic.dart';
import 'package:example/redux/search/searchState.dart';
import 'package:example/redux/search/searchReducer.dart';

final Store<SearchState> searchStore = Store<SearchState>(
  searchReducer,
  initialState: InitialSearchState(),
  middleware: [
    EpicMiddleware<SearchState>(
      SearchEpic(),
    ),
  ],
);
