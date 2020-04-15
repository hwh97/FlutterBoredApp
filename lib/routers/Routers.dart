import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'base_router.dart';

class Routers {
  static Router router = Router();

  static void configureRoutes(List<BaseRouter> routers) {
    routers.forEach((f) {
      f.defineRoutes(router);
    });
  }

  static Future<dynamic> navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
        bool replace = false,
        bool clearStack = false,
        TransitionType transition,
        Duration transitionDuration = const Duration(milliseconds: 250),
        RouteTransitionsBuilder transitionBuilder}) {
    if (params != null && params.length != 0) {
      path = path + paramsToString(params);
    }
    print("path $path");
    return router.navigateTo(context, path,
    replace: replace,
    clearStack: clearStack,
    transition: transition,
    transitionDuration: transitionDuration,
    transitionBuilder: transitionBuilder);
  }

  // params encode
  static String paramsToString(Map<String, dynamic> map) {
    String result = "?";
    int index = 0;
    for (String key in map.keys) {
      if (map[key] is List || map[key] is Map) {
        result += "${index == 0 ? "" : "&"}$key=${Uri.encodeFull(jsonEncode(map[key]))}";
      } else {
        result += "${index == 0 ? "" : "&"}$key=${Uri.encodeFull(map[key].toString())}";
      }
      index++;
    }
    return result;
  }
}
