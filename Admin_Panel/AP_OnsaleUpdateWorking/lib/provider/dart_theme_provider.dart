import 'package:admin_panel/services/dark_theme_preferences.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefernce dtp = DarkThemePrefernce();
  bool _darkTheme = false;

  bool get getDarkTheme {
    return _darkTheme;
  }

  set setDarkTheme(bool value) {
    _darkTheme = value;
    dtp.setDarkTheme(value);
    notifyListeners();
  }
}
