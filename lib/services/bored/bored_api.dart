import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:dio/dio.dart';

abstract class BoredApi {
  Future<BoredEntity> getRandomBored({int timeOutMills, CancelToken cancelToken});
}