import 'dart:convert';

import 'package:bored/generated/json/base/json_convert_content.dart';
import 'package:bored/models/bored_entity.dart';
import 'package:bored/routers/base_router.dart';
import 'package:bored/ui/views/bored/bored_page.dart';
import 'package:fluro/fluro.dart';

class HomeRouter extends BaseRouter {
  static String home = "/bored";

  Map<String, Handler> handlers;

  HomeRouter() {
    handlers = {
      home: Handler(handlerFunc: (c, p) {
        return BoredPage(
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
    if (t == null) {
      final data = jsonDecode(parameters[key].first);
      // 自定义序列化对象处理
      if (data != null) {
        if (T.toString() == "BoredEntity") {
          t = BoredEntity().fromJson(data) as T;
        }
//        else if (T.toString() == "List<BoredEntity>") {
//          t = data
//              .map((e) => BoredEntity().fromJson(e))
//              .toList().cast<BoredEntity>() as T;
//        }
      }
    }
    return t;
  }
}
