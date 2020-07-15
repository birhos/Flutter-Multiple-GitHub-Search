import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:example/locator.dart';
import 'package:example/resources/dataHandler.dart';
import 'package:example/blocs/search/searchEvent.dart';
import 'package:example/blocs/search/searchState.dart';
import 'package:example/blocs/search/searchResult.dart';

class SearchBloc {
  final Sink<SearchEvent> event;
  final Stream<SearchState> state;

  SearchBloc._(this.event, this.state);

  factory SearchBloc() {
    final PublishSubject<SearchEvent> event = PublishSubject<SearchEvent>();

    final Stream<SearchState> state = event
        // Event Değişmediği Sürece State Değişmeyecek.
        .distinct()
        // Event Gelmeden Önce Bir Süre Beklenecek.
        .debounceTime(const Duration(milliseconds: 250))
        // Gelen Eventleri State'e Dönüştürüyor.
        .switchMap<SearchState>((SearchEvent event) => _mapEventToState(event))
        // Arayüzde Gösterilecek İlk State.
        .startWith(InitialSearchState());

    return SearchBloc._(event, state);
  }

  static Stream<SearchState> _mapEventToState(SearchEvent event) async* {
    final GithubRepository githubRepository = locator<GithubRepository>();

    if (event is SearchFetched) {
      yield* _mapSearchFetchedToState(event.term, githubRepository);
    } else if (event is SearchStateReset) {
      yield* _mapSearchStateResetToState();
    }
  }

  static Stream<SearchState> _mapSearchFetchedToState(
      String term, GithubRepository githubRepository) async* {
    if (term.isEmpty) {
      yield InitialSearchState();
    } else {
      yield SearchLoadingState();

      try {
        final SearchResult result = await githubRepository.search(term);
        if (result.isEmpty) {
          yield SearchEmptyState();
        } else {
          yield SearchLoadedState(result: result);
        }
      } catch (e) {
        yield SearchErrorState();
      }
    }
  }

  static Stream<SearchState> _mapSearchStateResetToState() async* {
    yield InitialSearchState();
  }

  void dispose() {
    event?.close();
  }
}
