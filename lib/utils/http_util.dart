import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const BASE_URL = "https://www.boredapi.com/api/";

class DioBuilder {
  static Dio create(
      {int connectTimeOut,
      int receiveTimeout,
      List<Interceptor> interceptors}) {
    Dio _dio = Dio();
    // Set default configs
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = connectTimeOut ?? 10000; //10s
    _dio.options.receiveTimeout = receiveTimeout ?? 10000;
    _dio.interceptors.addAll(interceptors ?? [BaseResponseInterceptor()]);
    return _dio;
  }
}

class HttpRequest {
  static Dio _dio =
      DioBuilder.create();

  Dio get dio => _dio;

  static Future<Map<String, dynamic>> getActivityWithTimeOut(int timeOutMills,
      {CancelToken cancelToken}) async {
    Dio _dio = DioBuilder.create(
        connectTimeOut: timeOutMills,
        receiveTimeout: timeOutMills);
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
  @override
  Future onResponse(Response response) {
    debugPrint("on response: ${response.data}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    debugPrint("on error: ${err.toString()}");
    return super.onError(err);
  }
}
