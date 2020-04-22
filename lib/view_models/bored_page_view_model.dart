import 'package:bored/models/bored_entity.dart';
import 'package:bored/models/bored_todo_entity.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/ui/views/bored/bored_todo_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoredPageViewModel extends ChangeNotifier {
  static const int fadeAnimationTime = 300;

  final BoredApi _boredApi = serviceLocator<BoredApi>();
  CancelToken _cancelToken;

  BoredEntity _boredEntity;

  BoredEntity get boredEntity => _boredEntity;
  List<BoredTodoEntity> _collectList = [];

  List<BoredTodoEntity> get collectList => _collectList;

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
      BoredEntity boredEntity =
          await _boredApi.getRandomBored(cancelToken: _cancelToken);
      _boredEntity = boredEntity ?? _boredEntity;
    } catch (e) {
      debugPrint("load data err: ${e.toString()}");
    } finally {
      controller.forward();
    }
    notifyListeners();
  }

  void loadTodoList() async {
    await getTodoList();
    for (BoredTodoEntity entity in collectList) {
      listKey.currentState.insertItem(0);
    }
  }

  void collectBored() async {
    if (_collectList.indexWhere((m) => m.key == _boredEntity.key) == -1) {
      await _boredApi.addBoredTodo(boredEntity);
      await getTodoList();
      listKey.currentState.insertItem(0,
          duration: const Duration(milliseconds: fadeAnimationTime));
    }
  }

  void deleteBored(int index) async {
    BoredTodoEntity entity = _collectList[index];
    await _boredApi.deleteBoredTodo(entity.id);
    await getTodoList();
    listKey.currentState.removeItem(index,
        (ctx, animation) => TodoItem(todoEntity: entity, animation: animation),
        duration: Duration(milliseconds: BoredPageViewModel.fadeAnimationTime));
  }

  Future<List<BoredTodoEntity>> getTodoList() async {
    _collectList = await serviceLocator.get<BoredApi>().getBoredTodoList();
    return _collectList;
  }
}
