import 'dart:convert';

import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/routers/base_router.dart';
import 'package:bored/ui/views/bored_page.dart';
import 'package:fluro/fluro.dart';

class HomeRouter extends BaseRouter {
  static String home = "/bored";

  Map<String, Handler> handlers;

  HomeRouter() {
    handlers = {
      home: Handler(handlerFunc: (c, p) {
        return BoredPage(
          title: getRouterParams<String>(p, "title"),
          boredEntity: getRouterParams<BoredEntity>(p, "data"),
        );
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
    final data = jsonDecode(parameters[key].first);
    if (t == null && data != null) {
      // 序列化对象处理
      if (T.toString() == "BoredEntity") {
        t = BoredEntity().fromJson(data) as T;
      }
    }
    return t;
  }
}
