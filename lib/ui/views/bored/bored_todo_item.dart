import 'package:bored/generated/l10n.dart';
import 'package:bored/models/bored_todo_entity.dart';
import 'package:bored/utils/date_util.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  final BoredTodoEntity todoEntity;
  final Animation<double> animation;
  final VoidCallback onClickItem;

  const TodoItem({Key key, this.todoEntity, this.animation, this.onClickItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todoEntity.status == 1
        ? ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), BlendMode.dstOut),
            child: buildItem(context),
          )
        : buildItem(context);
  }

  Widget buildItem(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.w,
            bottom: 5.w,
            left: 10.w,
            right: 10.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: 0.0, //extend the s
                ),
              ],
            ),
            height: 100.w,
            width: double.maxFinite,
            child: Material(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.w),
              child: InkWell(
                onTap: onClickItem,
                borderRadius: BorderRadius.circular(10.w),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        todoEntity.activity,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color:
                              Provider.of<AppViewModel>(context).isDark(context)
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 4.w, bottom: 2.w),
                              child: Text(
                                '${S.of(context).participants}',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  todoEntity.participants,
                                  (index) {
                                    return Padding(
                                      padding: index == 0
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(left: 6.w),
                                      child: Icon(
                                        Icons.mood,
                                        size: 16,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              DateUtil.formatTodoListItemDate(
                                  todoEntity.createAt),
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
