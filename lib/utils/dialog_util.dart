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
    return showDialog(
      context: _routers.context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
    return showDialog(
      context: _routers.context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title),
          children: List.generate(
            options.length,
            (index) => SimpleDialogOption(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  children: <Widget>[
                    Text(options[index]),
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
}
