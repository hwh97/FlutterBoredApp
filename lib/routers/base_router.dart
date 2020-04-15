import 'dart:convert';

import 'package:fluro/fluro.dart';

abstract class BaseRouter {
  void defineRoutes(Router router);

  // support int|bool|string|double|Map|List<int|bool|string|double|Map> for now
  T getRouterParams<T>(
      Map<String, List<String>> parameters, String key) {
    switch (T.toString()) {
      case "int":
      case "String":
      case "bool":
      case "double":
        return jsonDecode(parameters[key].first) as T;
      case "List<int>":
        return jsonDecode(parameters[key].first).cast<int>() as T;
      case "List<String>":
        return jsonDecode(parameters[key].first).cast<String>() as T;
      case "List<bool>":
        return jsonDecode(parameters[key].first).cast<bool>() as T;
      case "List<double>":
        return jsonDecode(parameters[key].first).cast<double>() as T;
      case "List<Map<dynamic, dynamic>>":
        return jsonDecode(parameters[key].first).cast<Map<dynamic, dynamic>>() as T;
      case "Map<dynamic, dynamic>":
        return jsonDecode(parameters[key].first) as T;
      default:
        return null;
    }
  }
}
