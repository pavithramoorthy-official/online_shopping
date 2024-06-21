import 'package:admin_panel/controllers/menu_controller.dart' as item;
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard_screen.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/header.dart';
import 'package:admin_panel/widgets/product_grid_widget.dart';
import 'package:admin_panel/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
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
                // physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Header(
                      fcn: () {
                        context
                            .read<item.MenuController>()
                            .controlProductsMEnu();
                      },
                      title: 'All Products',
                    ),
                    Responsive(
                      mobile: ProductGridWidget(
                        isInMain: false,
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: ProductGridWidget(
                        isInMain: false,
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                      ),
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
