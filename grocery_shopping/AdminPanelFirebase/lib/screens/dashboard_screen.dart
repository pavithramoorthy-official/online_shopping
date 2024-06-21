import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/inner_screens/add_prod_form.dart';
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/buttons.dart';

import 'package:admin_panel/widgets/header.dart';
import 'package:admin_panel/widgets/orders_list.dart';
import 'package:admin_panel/widgets/product_grid_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utilities(context).getScreenSize;
    Color color = Utilities(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fcn: () {
                context.read<MenuController>();
              },
              title: 'Dashboard',
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const Text('Latest Products'),
            const SizedBox(
              height: 15,
            ),
            Row(children: [
              ButtonWidget(
                onPressed: () {},
                text: 'View all',
                icon: Icons.store,
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              ButtonWidget(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductForm()));
                },
                text: 'Add Products',
                icon: Icons.add,
                backgroundColor: Colors.blue,
              ),
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  //flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: ProductGridWidget(
                          crossAxisCount: size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        ),
                        desktop: ProductGridWidget(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      ),
                      const OrdersList(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
