import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping/inner_screens/product_details.dart';
import 'package:grocery_shopping/models/orders_model.dart';
import 'package:grocery_shopping/providers/product_providers.dart';
import 'package:grocery_shopping/services/global_methods.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;
  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrdersModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final productProviders = Provider.of<ProductProviders>(context);
    final getCurrentProduct =
        productProviders.findProductbyId(ordersModel.productId);
    final Color color = Utilities(context).color;
    Size size = Utilities(context).getScreenSize;
    return ListTile(
      subtitle: Text(
          'Paid: Rs ${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: getCurrentProduct.imageUrl, //we can also use orders.imageUrl
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
          text: '${getCurrentProduct.title} X ${ordersModel.quantity}',
          color: color,
          textSize: 18),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
    );
  }
}
