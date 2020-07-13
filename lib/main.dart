import 'dart:io';

import 'package:bored/consts/config_constants.dart';
import 'package:bored/generated/l10n.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:bored/routers/home_router.dart';
import 'package:bored/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return LocalListener(
      child: MaterialApp(
        onGenerateTitle: (BuildContext context) {
          return ConfigConstants.appName(context);
        },
        color: Colors.redAccent,
        theme:
            Provider.of<AppViewModel>(context).getThemeData(darkTheme: false),
        darkTheme:
            Provider.of<AppViewModel>(context).getThemeData(darkTheme: true),
        locale: Provider.of<AppViewModel>(context).locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: Routers.router.generator,
        home: SplashPage(),
      ),
    );
  }
}

class LocalListener extends StatefulWidget {
  final Widget child;

  const LocalListener({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LocalListenerState();
}

class LocalListenerState extends State<LocalListener>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale> locale) {
    super.didChangeLocales(locale);
    // call when locales changed
    // eg. [zh_Hans_CN, en_US] eg. [en_US, zh_Hans_CN]
    if (Provider.of<AppViewModel>(context, listen: false).appLanguage ==
        AppLanguage.System) {
      Provider.of<AppViewModel>(context, listen: false).setLocale(
        locale: locale[0],
        isFollowSystem: true,
      );
    }
  }
}
