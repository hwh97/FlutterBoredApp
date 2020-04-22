import 'dart:io';

import 'package:bored/utils/db_util.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:bored/routers/home_router.dart';
import 'package:bored/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'routers/Routers.dart';
import 'ui/views/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  setUpServiceLocator();
  Routers.configureRoutes([
    HomeRouter(),
  ]);

  runApp(ChangeNotifierProvider.value(
    value: serviceLocator.get<AppViewModel>(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boring Destoryer',
      color: Colors.redAccent,
      theme: Provider.of<AppViewModel>(context).getThemeData(darkTheme: false),
      darkTheme:
          Provider.of<AppViewModel>(context).getThemeData(darkTheme: true),
      onGenerateRoute: Routers.router.generator,
      home: SplashPage(),
    );
  }
}
