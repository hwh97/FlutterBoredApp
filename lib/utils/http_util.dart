import 'dart:convert';

import 'package:bored/utils/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const BASE_URL = "https://www.boredapi.com/api/";
const TIME_OUT_LIMIT = 10000; // 10s

class DioBuilder {
  static Dio create(
      {int connectTimeOut,
      int receiveTimeout,
      List<Interceptor> interceptors}) {
    Dio _dio = Dio();
    // Set default configs
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = connectTimeOut ?? TIME_OUT_LIMIT; //10s
    _dio.options.receiveTimeout = receiveTimeout ?? TIME_OUT_LIMIT;
    _dio.interceptors.addAll(interceptors ?? [BaseResponseInterceptor()]);
    return _dio;
  }
}

class HttpRequest {
  static Dio _dio = DioBuilder.create();

  Dio get dio => _dio;

  static Future<Map<String, dynamic>> getActivityWithTimeOut(int timeOutMills,
      {CancelToken cancelToken}) async {
    Dio _dio = DioBuilder.create(
        connectTimeOut: timeOutMills, receiveTimeout: timeOutMills);
    var response = await _dio.get("activity", cancelToken: cancelToken);
    return response.data;
  }

  static Future<Map<String, dynamic>> getActivity(
      {CancelToken cancelToken}) async {
    var response = await _dio.get("activity", cancelToken: cancelToken);
    return response.data;
  }
}

class BaseResponseInterceptor extends Interceptor {
  DateTime _time;

  @override
  Future onRequest(RequestOptions options) {
    _time = DateTime.now();
    logger.d("""
url:    ${options.baseUrl}${options.path}
method: ${options.method}
header: ${options.headers}
params: ${options.method == 'POST' ? options.data is Map ? json.encode(options.data) : options.data : options.queryParameters}""");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    logger.d("""
time:   ${DateTime.now().millisecondsSinceEpoch - _time.millisecondsSinceEpoch}
url:    ${response.request.baseUrl}${response.request.path}
method: ${response.request.method}
header: ${response.request.headers}
params: ${response.request.method == 'POST' ? response.request.data is Map ? json.encode(response.request.data) : response.request.data : response.request.queryParameters}
status: ${response.statusCode}
resp:   ${response.toString()}""");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    logger.e("""
time:   ${DateTime.now().millisecondsSinceEpoch - _time.millisecondsSinceEpoch}
url:    ${err.request.baseUrl}${err.request.path}
method: ${err.request.method}
header: ${err.request.headers}
params: ${err.request.method == 'POST' ? err.request.data is Map ? json.encode(err.request.data) : err.request.data : err.request.queryParameters}
status: ${err.response?.statusCode ?? ""}
msg:    ${err.toString()}""");
    return super.onError(err);
  }
}
