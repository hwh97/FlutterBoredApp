import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/service_locator.dart';
import 'package:flutter/foundation.dart';

class BoredPageViewModel extends ChangeNotifier {
  final BoredApi _boredApi = serviceLocator<BoredApi>();

  BoredEntity _boredEntity;
  BoredEntity get boredEntity => _boredEntity;

  void loadData() async {
    _resetEntity();
    _boredEntity = await _boredApi.getRandomBored();
    notifyListeners();
  }

  void _resetEntity() {
    _boredEntity = null;
    notifyListeners();
  }
}