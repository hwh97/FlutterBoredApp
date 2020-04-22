import 'package:bored/models/bored_entity.dart';
import 'package:bored/routers/Routers.dart';
import 'package:bored/routers/home_router.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SplashPageViewModel extends ChangeNotifier {
  final BoredApi _boredApi = serviceLocator<BoredApi>();

  void prepareData(BuildContext context) async {
    BoredEntity _boredEntity;
    try {
      _boredEntity = await _boredApi.getRandomBored(timeOutMills: 1500);
    } catch (e) {
      debugPrint("splash page err: ${e.toString()}");
    } finally {
      Routers.navigateTo(
        context,
        HomeRouter.home,
        params: {"title": "Boring destroyer", "data": _boredEntity?.toJson()},
        replace: true,
        transition: TransitionType.fadeIn,
      );
    }
  }
}