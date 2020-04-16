import 'package:flutter/material.dart';

enum ThemeModel {
  System, Light, Dark
}

class AppViewModel extends ChangeNotifier {
  ThemeModel _themeModel;
  
  bool isDark(BuildContext context) {
    if (_themeModel != null && _themeModel != ThemeModel.System) {
      return _themeModel == ThemeModel.Dark;
    }
    return Theme.of(context).brightness == Brightness.dark; 
  }

  ThemeData getThemeData({bool darkTheme}) {
    if (_themeModel != null && _themeModel != ThemeModel.System) {
      return _getTheme(_themeModel == ThemeModel.Dark);
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
      scaffoldBackgroundColor: Colors.white,
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

  void setDarkModel(ThemeModel _themeModel) {
    this._themeModel = _themeModel;
    notifyListeners();
  }
}
