import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoredPageViewModel extends ChangeNotifier {
  final BoredApi _boredApi = serviceLocator<BoredApi>();
  CancelToken _cancelToken;

  BoredEntity _boredEntity;
  BoredEntity get boredEntity => _boredEntity;
  List<BoredEntity> _collectList = [];
  List<BoredEntity> get collectList => _collectList;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void init(BoredEntity boredEntity) async {
    this._boredEntity = boredEntity;
    notifyListeners();
  }

  void loadData(AnimationController controller) async {
    try {
      if (controller.isAnimating) {
        return;
      }
      if (_cancelToken != null && !_cancelToken.isCancelled) {
        _cancelToken.cancel("reload");
      }
      controller.repeat();
      _cancelToken = CancelToken();
      BoredEntity boredEntity = await _boredApi.getRandomBored(cancelToken: _cancelToken);
      _boredEntity = boredEntity ?? _boredEntity;
    } catch (e) {
      debugPrint("load data err: ${e.toString()}");
    } finally {
      controller.forward();
    }
    notifyListeners();
  }

  void addBoredEntity() {
    if (_collectList.indexWhere((m) => m.key == _boredEntity.key) == -1) {
      _collectList.insert(0, boredEntity);
      listKey.currentState.insertItem(0, duration: const Duration(milliseconds: 500));
//      notifyListeners();
    }
  }
}