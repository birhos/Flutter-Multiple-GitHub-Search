import 'package:common/common.dart';
import 'package:get_it/get_it.dart';

import 'listenable/search/search.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GithubRepository());
  locator.registerFactory(() => SearchListenable());
}
