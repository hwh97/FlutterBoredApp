import 'package:bored/generated/l10n.dart';
import 'package:bored/models/bored_entity.dart';
import 'package:bored/models/bored_todo_entity.dart';
import 'package:bored/routers/setting_router.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/ui/views/bored/bored_todo_item.dart';
import 'package:bored/utils/dialog_util.dart';
import 'package:bored/utils/router_util.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoredPageViewModel extends ChangeNotifier {
  static const int fadeAnimationTime = 300;

  final BoredApi _boredApi = serviceLocator<BoredApi>();
  final RouterUtil _routers = serviceLocator.get<RouterUtil>();
  final DialogUtil _dialogUtil = serviceLocator.get<DialogUtil>();
  CancelToken _cancelToken;

  BoredEntity _boredEntity;

  BoredEntity get boredEntity => _boredEntity;
  List<BoredTodoEntity> _collectList = [];

  bool get isEmpty => _isEmpty;
  bool _isEmpty = true;

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
    notifyListeners();

    for (BoredTodoEntity entity in collectList) {
      listKey.currentState.insertItem(0);
    }
  }

  void goSettingPage(BuildContext context) async {
    _routers.navigateTo(SettingRouter.setting, transition: TransitionType.fadeIn);
  }

  void collectBored() async {
    await _boredApi.addBoredTodo(boredEntity);
    await getTodoList();
    notifyListeners();

    listKey.currentState.insertItem(0,
        duration: const Duration(milliseconds: fadeAnimationTime));
  }

  void showBoredDialog(BuildContext context, int index) async {
    _dialogUtil.showTodoListDialog(
      completedText: S.of(context).completed,
      deleteText: S.of(context).delete,
      barrierDismissible: true,
      onSelectCompleted: () => completeBored(index),
      onSelectDelete: () => deleteBored(index),
    );
  }

  void completeBored(int index) async {
    BoredTodoEntity entity = _collectList[index];
    if (entity.status == 1) return;
    await _boredApi.completeBoredTodo(entity.id);
    await getTodoList();
    // ignore: invalid_use_of_protected_member
    listKey.currentState.setState(() { });
  }

  void deleteBored(int index) async {
    BoredTodoEntity entity = _collectList[index];
    await _boredApi.deleteBoredTodo(entity.id);
    await getTodoList();
    Future.delayed(Duration(milliseconds: BoredPageViewModel.fadeAnimationTime), () {
      notifyListeners();
    });

    listKey.currentState.removeItem(index,
        (ctx, animation) => TodoItem(todoEntity: entity, animation: animation),
        duration: Duration(milliseconds: BoredPageViewModel.fadeAnimationTime));
  }

  Future<List<BoredTodoEntity>> getTodoList() async {
    _collectList = await serviceLocator.get<BoredApi>().getBoredTodoList();
    return _collectList;
  }
}
