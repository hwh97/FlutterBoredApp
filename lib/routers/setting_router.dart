import 'package:bored/routers/base_router.dart';
import 'package:bored/ui/views/setting_page.dart';
import 'package:fluro/fluro.dart';

class SettingRouter extends BaseRouter {
  static String setting = "/settingPage";

  Map<String, Handler> handlers;

  SettingRouter() {
    handlers = {
      setting: Handler(handlerFunc: (c, p) {
        return SettingPage();
      }),
    };
  }

  @override
  void defineRoutes(Router router) {
    handlers.forEach((k, v) {
      router.define(k, handler: v);
    });
  }

  @override
  T getRouterParams<T>(Map<String, List<String>> parameters, String key) {
    T t = super.getRouterParams(parameters, key);
    if (t == null) {
    }
    return t;
  }
}