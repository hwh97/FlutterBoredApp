import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BoredPageViewModel extends ChangeNotifier {
  final BoredApi _boredApi = serviceLocator<BoredApi>();
  CancelToken _cancelToken;

  BoredEntity _boredEntity;
  BoredEntity get boredEntity => _boredEntity;

  void init(BoredEntity boredEntity) async {
    this._boredEntity = boredEntity;
    notifyListeners();
  }

  void loadData() async {
    _resetEntity();
    _cancelToken = CancelToken();
    _boredEntity = await _boredApi.getRandomBored(cancelToken: _cancelToken);
    notifyListeners();
  }

  void _resetEntity() {
    if (_cancelToken != null && !_cancelToken.isCancelled) {
      _cancelToken.cancel("reload");
    }
    _boredEntity = null;
    notifyListeners();
  }
}