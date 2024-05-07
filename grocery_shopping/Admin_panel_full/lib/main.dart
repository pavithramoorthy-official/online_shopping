import 'package:admin_panel/constants/theme_data.dart';
import 'package:admin_panel/provider/dart_theme_provider.dart';
import 'package:admin_panel/screens/main_screen.dart';
import 'package:admin_panel/services/dark_theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/controllers/menu_controller.dart' as item;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.dtp.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => item.MenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeprovider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Grocery",
            theme: Styles.themeData(themeprovider.getDarkTheme, context),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
