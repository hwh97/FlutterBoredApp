import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const BASE_URL = "https://www.boredapi.com/api/";

class HttpRequest {
  static Dio _dio = Dio();

  Dio get dio => _dio;

  static void init() {
    // Set default configs
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = 10000; //10s
    _dio.options.receiveTimeout = 10000;
    _dio.interceptors.add(BaseResponseInterceptor());
  }

  static Future<Map<String, dynamic>> getActivity() async {
    var response = await _dio.get("activity");
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
