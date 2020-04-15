import 'dart:io';

import 'package:bored/routers/home_router.dart';
import 'package:bored/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'business_logic/utils/http_request.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.redAccent,
      theme: ThemeData(
        accentColor: Color(0xFF30336B),
        primaryColor: Color(0xFF30336B),
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routers.router.generator,
      home: SplashPage(),
    );
  }
}
