import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'searchEpic.dart';
import 'searchReducer.dart';
import 'searchState.dart';

final Store<SearchState> searchStore = Store<SearchState>(
  searchReducer,
  initialState: InitialSearchState(),
  middleware: [
    EpicMiddleware<SearchState>(
      SearchEpic(),
    ),
  ],
);
