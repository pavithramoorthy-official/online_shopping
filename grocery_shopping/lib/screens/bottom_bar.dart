import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/provider/dark_theme_provider.dart';
import 'package:grocery_shopping/screens/cart.dart';
import 'package:grocery_shopping/screens/categories.dart';
import 'package:grocery_shopping/screens/home_screen.dart';
import 'package:grocery_shopping/screens/user.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const UserScreen()
  ];
  /* final List<Map<String, dynamic>> _screens = [
    {'page': const HomeScreen(), 'title': 'Home'},
    {'page': const CategoriesScreen(), 'title': 'Categories'},
    {'page': const CartScreen(), 'title': 'Cart'},
    {'page': const UserScreen(), 'title': 'User'}
  ];*/

  void _SelectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      /*appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title']),
      ),*/
      body: _screens[
          _selectedScreenIndex], //_screens[_selectedScreenIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isDark
              ? Theme.of(context).cardColor
              : Colors.white, //Colors.purpleAccent.shade200,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: isDark ? Colors.white12 : Colors.black26,
          selectedItemColor:
              isDark ? Colors.lightBlueAccent.shade200 : Colors.black87,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedScreenIndex,
          onTap: _SelectedScreen,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(_selectedScreenIndex == 0
                  ? IconlyBold.home
                  : IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedScreenIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedScreenIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedScreenIndex == 3
                  ? IconlyBold.user2
                  : IconlyLight.user2),
              label: "User",
            ),
          ]),
    );
  }
}
