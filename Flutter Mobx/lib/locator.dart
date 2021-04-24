import 'package:get_it/get_it.dart';

import 'package:common/common.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GithubRepository());
}
