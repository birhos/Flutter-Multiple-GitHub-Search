import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/searchPage.dart';
import 'controller/search/search.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  EquatableConfig.stringify = true;

  Get.put(SearchController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get - Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchPage(),
    );
  }
}
