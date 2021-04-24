import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/search/searchAction.dart';
import '../redux/search/searchState.dart';

class _SearchPageModel {
  final SearchState currentState;
  final void Function(String term) fetched;
  final void Function() stateReset;

  _SearchPageModel({
    required this.currentState,
    required this.fetched,
    required this.stateReset,
  });
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SearchState, _SearchPageModel>(
      converter: (store) {
        return _SearchPageModel(
          currentState: store.state,
          fetched: (String term) => store.dispatch(SearchFetched(term: term)),
          stateReset: () => store.dispatch(SearchStateReset()),
        );
      },
      builder: (BuildContext context, _SearchPageModel viewModel) {
        return Scaffold(
          body: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Github...',
                  ),
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: "Hind",
                    decoration: TextDecoration.none,
                  ),
                  onChanged: viewModel.fetched,
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _buildWidget(viewModel.currentState),
                ),
              ),
            ],
          ),
          floatingActionButton: SizedBox(
            height: 75,
            width: 75,
            child: FloatingActionButton(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      "Initial State",
                    ),
                  ),
                ),
              ),
              onPressed: () {
                viewModel.stateReset();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildWidget(SearchState state) {
    if (state is InitialSearchState) {
      return InitialSearchWidget();
    } else if (state is SearchLoadingState) {
      return SearchLoadingWidget();
    } else if (state is SearchEmptyState) {
      return SearchEmptyWidget();
    } else if (state is SearchLoadedState) {
      return SearchLoadedWidget(items: state.result.items);
    } else if (state is SearchErrorState) {
      return SearchErrorWidget();
    }

    throw Exception('${state.runtimeType} is not supported.');
  }
}
