import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/widgets/header.dart';
import 'package:admin_panel/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Header(
              fcn: () {
                context.read<MenuController>();
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  //flex: 5,
                  child: Column(
                    children: [
                      SizedBox(
                        child: ProductWidget(),
                      ),
                      //MyproductsHome(),
                      //Sizedbox(height: defaultPadding),
                      //OrdersScreen();
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
