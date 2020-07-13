import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  SharedPreferences _prefs;

  Future<SpUtil> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// set object.
  Future<bool> setObject(String key, Object value) {
    return _prefs?.setString(key, value == null ? "" : json.encode(value));
  }

  /// get object.
  Map getObject(String key) {
    String _data = _prefs?.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// set object list.
  Future<bool> setObjectList(String key, List<Object> list) {
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return _prefs?.setStringList(key, _dataList);
  }

  /// get object list.
  List<Map> getObjectList(String key) {
    List<String> _dataList = _prefs?.getStringList(key);
    return _dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  /// get string.
  String getString(String key) {
    return _prefs?.getString(key);
  }

  /// set string.
  Future<bool> setString(String key, String value) {
    return _prefs?.setString(key, value);
  }

  /// get bool.
  bool getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// set bool.
  Future<bool> setBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  /// get int.
  int getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// set int.
  Future<bool> setInt(String key, int value) {
    return _prefs?.setInt(key, value);
  }

  /// get double.
  double getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// set double.
  Future<bool> setDouble(String key, double value) {
    return _prefs?.setDouble(key, value);
  }

  /// get string list.
  List<String> getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// set string list.
  Future<bool> setStringList(String key, List<String> value) {
    return _prefs?.setStringList(key, value);
  }

  /// get dynamic.
  dynamic getDynamic(String key) {
    return _prefs?.get(key);
  }

  /// has key.
  bool hasKey(String key) {
    return _prefs?.getKeys()?.contains(key);
  }

  /// get keys.
  Set<String> getKeys() {
    return _prefs?.getKeys();
  }

  /// remove.
  Future<bool> remove(String key) {
    return _prefs?.remove(key);
  }

  /// clear.
  Future<bool> clear() {
    return _prefs?.clear();
  }

  ///Sp is initialized.
  bool isInitialized() {
    return _prefs != null;
  }
}
