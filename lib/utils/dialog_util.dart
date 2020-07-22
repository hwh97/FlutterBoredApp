import 'package:animations/animations.dart';
import 'package:bored/generated/l10n.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/utils/router_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnSelectSimpleDialog(int index);

class DialogUtil {
  final RouterUtil _routers = serviceLocator.get<RouterUtil>();

  Future showConfirmDialog(
      {@required String title,
      @required String content,
      bool barrierDismissible = true,
      VoidCallback onConfirm,
      VoidCallback onCancel}) {
    return showModal(
      context: _routers.context,
      configuration: FadeScaleTransitionConfiguration(
        barrierDismissible: barrierDismissible,
        reverseTransitionDuration: Duration(milliseconds: 150),
      ),
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontSize: 18.sp)),
          content: Text(
            content,
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (onCancel != null) {
                  onCancel();
                }
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            FlatButton(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                }
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );
  }

  Future showSimpleDialog(
      {@required String title,
      @required List<String> options,
      @required int initialIndex,
      bool barrierDismissible = true,
      OnSelectSimpleDialog onSelectSimpleDialog}) {
    return showModal(
      context: _routers.context,
      configuration: FadeScaleTransitionConfiguration(
        barrierDismissible: barrierDismissible,
        reverseTransitionDuration: Duration(milliseconds: 150),
      ),
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title, style: TextStyle(fontSize: 18.sp)),
          children: List.generate(
            options.length,
            (index) => SimpleDialogOption(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      options[index],
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    Spacer(),
                    Offstage(
                      offstage: initialIndex != index,
                      child: Icon(
                        Icons.check,
                        size: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onSelectSimpleDialog != null) {
                  onSelectSimpleDialog(index);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future showTodoListDialog(
      {@required String completedText,
      @required String deleteText,
      bool barrierDismissible,
      VoidCallback onSelectCompleted,
      VoidCallback onSelectDelete}) {
    return showModal(
      context: _routers.context,
      configuration: FadeScaleTransitionConfiguration(
        barrierDismissible: barrierDismissible,
        reverseTransitionDuration: Duration(milliseconds: 150),
      ),
      builder: (BuildContext context) {
        return SimpleDialog(
          children: List.generate(
            2,
            (index) => SimpleDialogOption(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  children: <Widget>[
                    Text(
                      index == 0 ? completedText : deleteText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: index == 1 ? Colors.red : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (index == 0 && onSelectCompleted != null) {
                  onSelectCompleted();
                } else if (index == 1 && onSelectDelete != null) {
                  onSelectDelete();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
