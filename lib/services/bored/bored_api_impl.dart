import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/business_logic/utils/http_request.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BoredApiImpl extends BoredApi {
  @override
  Future<BoredEntity> getRandomBored(
      {int timeOutMills, CancelToken cancelToken}) async {
    BoredEntity _entity;
    try {
      if (timeOutMills != null) {
        _entity = BoredEntity().fromJson(
            await HttpRequest.getActivityWithTimeOut(timeOutMills, cancelToken: cancelToken));
      } else {
        _entity = BoredEntity()
            .fromJson(await HttpRequest.getActivity(cancelToken: cancelToken));
      }
    } catch (e) {
      debugPrint("err on get boredEntity: ${e.toString()}");
    }
    return _entity;
  }
}
