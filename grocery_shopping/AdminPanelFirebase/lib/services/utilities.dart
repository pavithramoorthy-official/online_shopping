import 'package:admin_panel/provider/dart_theme_provider.dart';
import 'package:admin_panel/services/dark_theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utilities {
  BuildContext context;
  Utilities(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
