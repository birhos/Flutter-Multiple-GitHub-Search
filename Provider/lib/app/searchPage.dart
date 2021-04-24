import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../changeNotifiers/search/search.dart';
import '../changeNotifiers/search/searchState.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchChangeNotifier _gitHubViewModel;

  @override
  void initState() {
    _gitHubViewModel = Provider.of<SearchChangeNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _gitHubViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchChangeNotifier>(
      builder: (BuildContext context, SearchChangeNotifier model, Widget? child) {
        final SearchState state = model.state;

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Flex(
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
                      onChanged: (String icerik) {
                        _gitHubViewModel.searchFetched(icerik);
                      },
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _buildWidget(state),
                    ),
                  )
                ],
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
                _gitHubViewModel.searchStateReset();
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

    throw Exception('${state.runtimeType} is not supported');
  }
}
