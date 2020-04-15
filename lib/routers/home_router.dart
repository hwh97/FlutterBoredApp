import 'package:bored/routers/base_router.dart';
import 'package:bored/ui/views/bored_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';

class HomeRouter extends BaseRouter {
  static String home = "/bored";

  final Map<String, Handler> handlers = {
    home: Handler(handlerFunc: (c, p) {
      return BoredPage(title: BaseRouter.getRouterParams<String>(p, "title"));
    }),
  };

  @override
  void defineRoutes(Router router) {
    handlers.forEach((k, v){
      router.define(k, handler: v);
    });
  }
}