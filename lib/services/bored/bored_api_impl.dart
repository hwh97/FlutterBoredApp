import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/business_logic/utils/http_request.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:flutter/cupertino.dart';

class BoredApiImpl extends BoredApi {
  @override
  Future<BoredEntity> getRandomBored() async {
    BoredEntity _entity;
    try {
      _entity = BoredEntity().fromJson(await HttpRequest.getActivity());
    } catch (e) {
      debugPrint("err on get boredEntity: ${e.toString()}");
    }
    return _entity;
  }
}