import 'package:bored/models/bored_entity.dart';
import 'package:bored/models/bored_todo_entity.dart';
import 'package:dio/dio.dart';

abstract class BoredApi {
  Future<BoredEntity> getRandomBored({int timeOutMills, CancelToken cancelToken});

  Future<List<BoredTodoEntity>> getBoredTodoList({int page = 1, int rows = 1000});

  Future<int> addBoredTodo(BoredEntity boredEntity);

  Future<int> deleteBoredTodo(int id);

  Future<int> completeBoredTodo(int id);
}