import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/onsale_widget.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});
  static const routeName = '/OnSaleScreen';

  @override
  Widget build(BuildContext context) {
    Color color = Utilities(context).color;
    Size size = Utilities(context).getScreenSize;
    bool _isEmpty = false;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(
            12,
          ),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        title: TextWidget(
          text: "Products on Sale",
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      // ignore: dead_code
      body: _isEmpty
          // ignore: dead_code
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/images/offers/emptybox.jpeg'),
                    ),
                    Text(
                      "No Products on Sale yet!!!\nStay Tuned...",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          // ignore: dead_code
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / size.width * 1.1,
              children: List.generate(10, (index) {
                return const OnsaleWidget();
              }),
            ),
    );
  }
}
