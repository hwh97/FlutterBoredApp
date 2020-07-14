import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../routers/base_router.dart';

class RouterUtil {
  final Router router = Router();
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>(debugLabel: "dialog_util_navigator_key");

  BuildContext get context => key.currentState.overlay.context;
  NavigatorState get state => key.currentState;

  void configureRoutes(List<BaseRouter> routers) {
    routers.forEach((f) {
      f.defineRoutes(router);
    });
  }

  Future<dynamic> navigateTo(String path,
      {Map<String, dynamic> params,
        bool replace = false,
        bool clearStack = false,
        TransitionType transition,
        Duration transitionDuration = const Duration(milliseconds: 200),
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
      result += "${index == 0 ? "" : "&"}$key=${Uri.encodeQueryComponent(jsonEncode(map[key]))}";
      index++;
    }
    return result;
  }
}
