import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:example/locator.dart';
import 'package:example/app/searchPage.dart';
import 'package:example/redux/search/searchState.dart';
import 'package:example/redux/search/searchStore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

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
