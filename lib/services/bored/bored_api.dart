import 'package:bored/business_logic/models/bored_entity.dart';

abstract class BoredApi {
  Future<BoredEntity> getRandomBored();
}