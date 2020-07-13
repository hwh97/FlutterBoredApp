import 'package:bored/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class ConfigConstants {
  static String appName(BuildContext context) => S.of(context).app_name;

  // share preferences keys
  static String get languageKey => "cur_language";
}