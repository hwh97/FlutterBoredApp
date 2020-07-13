import 'package:bored/consts/config_constants.dart';
import 'package:bored/generated/l10n.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/utils/sp_util.dart';
import 'package:flutter/material.dart';

enum AppThemeModel { System, Light, Dark }
enum AppLanguage {System, Chinese, English}

class AppViewModel extends ChangeNotifier {
  AppThemeModel _themeModel;
  AppLanguage _appLanguage = AppLanguage.System;
  Locale _locale;

  AppThemeModel get themeModel => _themeModel;
  AppLanguage get appLanguage => _appLanguage;
  Locale get locale => _locale;

  bool isDark(BuildContext context) {
    if (_themeModel != null && _themeModel != AppThemeModel.System) {
      return _themeModel == AppThemeModel.Dark;
    }
    return Theme.of(context).brightness == Brightness.dark;
  }

  ThemeData getThemeData({bool darkTheme}) {
    if (_themeModel != null && _themeModel != AppThemeModel.System) {
      return _getTheme(_themeModel == AppThemeModel.Dark);
    }
    return _getTheme(darkTheme);
  }

  ThemeData _getTheme(bool isDark) {
    return isDark
        ? ThemeData(
            brightness: Brightness.dark,
            accentColor: Color(0xFF30336B),
            primaryColor: Color(0xFF30336B),
            scaffoldBackgroundColor: Color(0xFF0D0D0D),
            textTheme: TextTheme(
              // Text默认文字样式
              body1: TextStyle(
                color: Colors.white,
              ),
            ),
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              brightness: Brightness.dark,
            ),
          )
        : ThemeData(
            brightness: Brightness.light,
            accentColor: Color(0xFF30336B),
            primaryColor: Color(0xFF30336B),
            scaffoldBackgroundColor: Color(0xFFF8F8F8),
            textTheme: TextTheme(
              // Text默认文字样式
              body1: TextStyle(
                color: Colors.black,
              ),
            ),
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              brightness: Brightness.light,
            ),
          );
  }

  void setDarkModel(AppThemeModel _themeModel) {
    this._themeModel = _themeModel;
    notifyListeners();
  }

  Future setLocale({Locale locale, bool isFollowSystem}) async {
    if (isFollowSystem) {
      _appLanguage = AppLanguage.System;
    } else {
      _appLanguage = locale.languageCode == "zh" ? AppLanguage.Chinese : AppLanguage.English;
      await serviceLocator.get<SpUtil>().setString(ConfigConstants.languageKey, locale.languageCode);
    }

    switch (locale.languageCode) {
      case "zh":
        _locale = Locale("zh", "CN");
        break;
      default:
        _locale = Locale("en", "US");
        break;
    }
//    S.load(locale);
    notifyListeners();
  }
}
