import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:example/locator.dart';
import 'package:example/app/searchPage.dart';
import 'package:example/listenable/search/search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(
    ScopedModel<SearchListenable>(
      model: SearchListenable(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scoped Model - Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}
