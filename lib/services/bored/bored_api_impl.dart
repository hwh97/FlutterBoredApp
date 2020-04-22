import 'package:bored/models/bored_entity.dart';
import 'package:bored/models/bored_todo_entity.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/services/db/bored_todo_table.dart';
import 'package:bored/utils/http_util.dart';
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
            await HttpRequest.getActivityWithTimeOut(timeOutMills,
                cancelToken: cancelToken));
      } else {
        _entity = BoredEntity()
            .fromJson(await HttpRequest.getActivity(cancelToken: cancelToken));
      }
    } catch (e) {
      debugPrint("err on get boredEntity: ${e.toString()}");
    }
    return _entity;
  }

  @override
  Future<List<BoredTodoEntity>> getBoredTodoList(
      {int page = 1, int rows = 1000}) async {
    List<Map> list =
    await serviceLocator.get<BoredTodoTable>().getTodoList(page, rows);
    return list.map((m) => BoredTodoEntity.fromMap(m)).toList();
  }

  @override
  Future<int> addBoredTodo(BoredEntity boredEntity) {
    return serviceLocator.get<BoredTodoTable>().insert(boredEntity);
  }

  @override
  Future<int> deleteBoredTodo(int id) {
    return serviceLocator.get<BoredTodoTable>().delete(deleteId: id);
  }
}
