import 'package:bored/services/db/bored_todo_table.dart';
import 'package:bored/utils/db_util.dart';
import 'package:bored/utils/dialog_util.dart';
import 'package:bored/utils/path_util.dart';
import 'package:bored/utils/router_util.dart';
import 'package:bored/utils/sp_util.dart';
import 'package:bored/view_models/bored_page_view_model.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:bored/view_models/setting_page_view_model.dart';
import 'package:bored/view_models/splash_page_view_model.dart';
import 'package:bored/services/bored/bored_api_fake.dart';
import 'package:bored/services/bored/bored_api_impl.dart';
import 'package:get_it/get_it.dart';

import 'services/bored/bored_api.dart';

GetIt serviceLocator = GetIt.instance;

setUpServiceLocator() {
  // register api services
  serviceLocator.registerLazySingleton<BoredApi>(() => BoredApiImpl());

  // register view models
  serviceLocator.registerLazySingleton<AppViewModel>(() => AppViewModel());
  serviceLocator.registerFactory<BoredPageViewModel>(() => BoredPageViewModel());
  serviceLocator.registerFactory<SplashPageViewModel>(() => SplashPageViewModel());
  serviceLocator.registerFactory<SettingPageViewModel>(() => SettingPageViewModel());

  // register utils
  serviceLocator.registerSingletonAsync(() => PathUtil().init());
  serviceLocator.registerSingletonAsync(() => SpUtil().init());
  serviceLocator.registerSingletonAsync<DbUtil>(() => DbUtil().init(), dependsOn: [PathUtil]);
  serviceLocator.registerSingleton(RouterUtil());
  serviceLocator.registerLazySingleton(() => DialogUtil());

  // register database services
  serviceLocator.registerLazySingleton<BoredTodoTable>(() => BoredTodoTable());
}
