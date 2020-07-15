import 'package:get_it/get_it.dart';

import 'package:example/resources/dataHandler.dart';
import 'package:example/changeNotifiers/search/search.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GithubRepository());
  locator.registerFactory(() => SearchChangeNotifier());
}
