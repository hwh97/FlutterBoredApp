import 'package:bored/business_logic/view_models/bored_page_view_model.dart';
import 'package:bored/business_logic/view_models/app_view_model.dart';
import 'package:bored/business_logic/view_models/splash_page_view_model.dart';
import 'package:bored/services/bored/bored_api_fake.dart';
import 'package:bored/services/bored/bored_api_impl.dart';
import 'package:get_it/get_it.dart';

import 'services/bored/bored_api.dart';

GetIt serviceLocator = GetIt.instance;

setUpServiceLocator() {
  // set up services
  serviceLocator.registerLazySingleton<BoredApi>(() => BoredApiImpl());

  // set up view models
  serviceLocator.registerLazySingleton<AppViewModel>(() => AppViewModel());
  serviceLocator.registerFactory<BoredPageViewModel>(() => BoredPageViewModel());
  serviceLocator.registerFactory<SplashPageViewModel>(() => SplashPageViewModel());
}
