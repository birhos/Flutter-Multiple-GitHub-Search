import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'app/searchPage.dart';
import 'locator.dart';
import 'redux/search/searchState.dart';
import 'redux/search/searchStore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  EquatableConfig.stringify = true;

  runApp(
    StoreProvider<SearchState>(
      store: searchStore,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redux - Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}
