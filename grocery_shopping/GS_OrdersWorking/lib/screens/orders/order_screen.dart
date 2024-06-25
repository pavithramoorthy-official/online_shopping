// ignore_for_file: no_leading_underscores_for_local_identifiers, dead_code

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/orders_providers.dart';
import 'package:grocery_shopping/screens/orders/order_widget.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/back_widget.dart';
import 'package:grocery_shopping/widgets/empty_cart.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = '/OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utilities(context).color;
    //Size size = Utilities(context).getScreenSize;
    bool _isEmpty = true;
    final ordersProviders = Provider.of<OrdersProviders>(context);
    final ordersList = ordersProviders.getOrders;

    return FutureBuilder(
        future: ordersProviders.fetchOrderFromFirebase(),
        builder: ((context, snapshot) {
          return ordersList.isEmpty
              ? const EmptyScreen(
                  imagePath: 'assets/images/offers/emptybox.jpeg',
                  title: 'You are yet to place an Order!!',
                  subTitle: 'Now is the Right time to Order!!!',
                  buttonText: 'Shop Now',
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: const BackWidget(),
                    elevation: 0,
                    centerTitle: false,
                    title: TextWidget(
                      text: 'Your orders (${ordersList.length})',
                      color: color,
                      textSize: 24.0,
                      isTitle: true,
                    ),
                    backgroundColor: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.9),
                  ),
                  body: ListView.separated(
                    itemCount: ordersList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: ChangeNotifierProvider.value(
                          value: ordersList[index],
                          child: const OrderWidget(),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: color,
                        thickness: 1,
                      );
                    },
                  ),
                );
        }));
  }
}
