import 'package:admin_panel/controllers/menu_controller.dart' as item;
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/header.dart';
import 'package:admin_panel/widgets/orders_list.dart';
import 'package:admin_panel/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utilities(context).getScreenSize;
    return Scaffold(
      key: context.read<item.MenuController>().getGridScafflodKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                controller: ScrollController(),
                // physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Header(
                      fcn: () {
                        context.read<item.MenuController>().controlAllOrders();
                      },
                      title: 'All Orders',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: OrdersList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
