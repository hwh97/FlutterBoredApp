import 'package:bored/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class DateUtil {
  // get format date
  static String formatDate(BuildContext context, Locale locale,
      {DateTime time}) {
    DateTime _time = time ?? DateTime.now().toLocal();
    if (locale.languageCode == "zh") {
      return S.of(context).format_date(
          "${_time.year}", _getMonth(context, _time.month), "${_time.day}",
          _getWeekDay(context, _time.weekday));
    }
    return S.of(context).format_date(
        _getWeekDay(context, _time.weekday), _time.day,
        _getMonth(context, _time.month), _time.year);
  }

  static String _getWeekDay(BuildContext context, int day) {
    switch (day) {
      case DateTime.monday:
        return S
            .of(context)
            .monday;
      case DateTime.tuesday:
        return S
            .of(context)
            .tuesday;
      case DateTime.wednesday:
        return S
            .of(context)
            .wednesday;
      case DateTime.thursday:
        return S
            .of(context)
            .thursday;
      case DateTime.friday:
        return S
            .of(context)
            .friday;
      case DateTime.saturday:
        return S
            .of(context)
            .saturday;
      case DateTime.sunday:
        return S
            .of(context)
            .sunday;
      default:
        return S
            .of(context)
            .unknown;
    }
  }

  static String _getMonth(BuildContext context, int month) {
    switch (month) {
      case DateTime.january:
        return S
            .of(context)
            .january;
      case DateTime.february:
        return S
            .of(context)
            .february;
      case DateTime.march:
        return S
            .of(context)
            .march;
      case DateTime.april:
        return S
            .of(context)
            .april;
      case DateTime.may:
        return S
            .of(context)
            .may;
      case DateTime.june:
        return S
            .of(context)
            .june;
      case DateTime.july:
        return S
            .of(context)
            .july;
      case DateTime.august:
        return S
            .of(context)
            .august;
      case DateTime.september:
        return S
            .of(context)
            .september;
      case DateTime.october:
        return S
            .of(context)
            .october;
      case DateTime.november:
        return S
            .of(context)
            .november;
      case DateTime.december:
        return S
            .of(context)
            .december;
      default:
        return S
            .of(context)
            .unknown;
    }
  }

  static String formatTodoListItemDate(String date) {
    DateTime _time = DateTime.parse(date).toLocal();
    return "${_time.month < 10 ? "0${_time.month}" : _time.month}-${_time.day <
        10 ? "0${_time.day}" : _time.day }";
  }
}
