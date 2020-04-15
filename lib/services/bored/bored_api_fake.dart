import 'dart:math';

import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:dio/dio.dart';

class BoredApiFake extends BoredApi {
  final List<Map<String, dynamic>> mockList = [
    {
      "activity": "Learn Express.js",
      "accessibility": 0.25,
      "type": "education",
      "participants": 1,
      "price": 0.1,
      "link": "https://expressjs.com/",
      "key": "3943506"
    },
    {
      "activity": "Learn a new programming language",
      "accessibility": 0.25,
      "type": "education",
      "participants": 1,
      "price": 0.1,
      "key": "5881028"
    },
    {
      "activity": "Learn how to play a new sport",
      "accessibility": 0.2,
      "type": "recreational",
      "participants": 1,
      "price": 0.1,
      "key": "5808228"
    },
    {
      "activity": "Learn how to fold a paper crane",
      "accessibility": 0.05,
      "type": "education",
      "participants": 1,
      "price": 0.1,
      "key": "3136036"
    }
  ];

  @override
  Future<BoredEntity> getRandomBored(
      {int timeOutMills, CancelToken cancelToken}) async {
    BoredEntity entity = await _getRandomBored();
    return entity;
  }

  Future<BoredEntity> _getRandomBored() async {
    // mock time interval
    await Future.delayed(Duration(milliseconds: 700));
    final random = Random();
    return BoredEntity().fromJson(mockList[random.nextInt(mockList.length)]);
  }
}
