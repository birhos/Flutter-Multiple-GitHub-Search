import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:example/locator.dart';
import 'package:example/app/searchPage.dart';
import 'package:example/changeNotifiers/search/search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

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
