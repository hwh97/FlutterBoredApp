import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseRouter {
  void defineRoutes(Router router);

  // support int|bool|string|double|List<int|bool|string|double>|Map for now
  static T getRouterParams<T>(
      Map<String, List<String>> parameters, String key) {
    debugPrint(T.toString());
    switch (T.toString()) {
      case "int":
        return int.parse(parameters[key].first) as T;
      case "String":
        return parameters[key].first.toString() as T;
      case "bool":
        return (parameters[key].first == "true") as T;
      case "double":
        return double.parse(parameters[key].first) as T;
      case "List<int>":
        return jsonDecode(parameters[key].first).cast<int>() as T;
      case "List<String>":
        return jsonDecode(parameters[key].first).cast<String>() as T;
      case "List<bool>":
        return jsonDecode(parameters[key].first).cast<bool>() as T;
      case "List<double>":
        return jsonDecode(parameters[key].first).cast<double>() as T;
      case "Map<dynamic, dynamic>":
        print(parameters[key].first);
        return jsonDecode(parameters[key].first) as T;
      default:
        return null;
    }
  }
}
