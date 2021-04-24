import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/searchPage.dart';
import 'changeNotifiers/search/search.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  EquatableConfig.stringify = true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchChangeNotifier>(
          create: (_) => SearchChangeNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider - Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}
