// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$stateAtom = Atom(name: '_SearchStore.state');

  @override
  SearchState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$searchFetchedAsyncAction = AsyncAction('_SearchStore.searchFetched');

  @override
  Future<void> searchFetched(String term) {
    return _$searchFetchedAsyncAction.run(() => super.searchFetched(term));
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void searchStateReset() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchStateReset');
    try {
      return super.searchStateReset();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
