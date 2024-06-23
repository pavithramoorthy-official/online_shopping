import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard_screen.dart';
import 'package:admin_panel/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/controllers/menu_controller.dart' as item;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<item.MenuController>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
