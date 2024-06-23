import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/widgets/orders_widget.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return const Column(
              children: [
                OrdersWidget(),
                Divider(
                  thickness: 3,
                ),
              ],
            );
          }),
    );
  }
}
