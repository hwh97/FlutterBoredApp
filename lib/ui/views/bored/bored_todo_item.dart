import 'package:bored/models/bored_todo_entity.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  final BoredTodoEntity todoEntity;
  final Animation<double> animation;

  const TodoItem({Key key, this.todoEntity, this.animation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        height: 100.w,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 0.0, //extend the s
            ),
          ],
        ),
        child: Text(
          todoEntity.activity,
          style: TextStyle(
            color: Provider.of<AppViewModel>(context).isDark(context)
                ? Colors.white
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
