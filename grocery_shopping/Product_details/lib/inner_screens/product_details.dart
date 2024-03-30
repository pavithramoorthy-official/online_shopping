import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/services/global_methods.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/heart_icon.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  static const routeName = '/ProductDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final quantityTextController = TextEditingController();
  @override
  void initState() {
    quantityTextController.text = '1'; // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    quantityTextController.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utilities(context).color;
    Size size = Utilities(context).getScreenSize;
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
              // height: size.width * 0.21,
              width: size.width,
              boxFit: BoxFit.scaleDown,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: "Title",
                            color: color,
                            textSize: 24,
                            isTitle: true,
                          ),
                        ),
                        const HeartIconWidget(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: "Rs 50.00/kg",
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Visibility(
                          visible: true,
                          child: TextWidget(
                            text: "Rs 100.00",
                            color: color,
                            textSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: TextWidget(
                                text: "Free Delivery",
                                color: Colors.white,
                                textSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      quantityIconController(
                        fcn: () {
                          if (quantityTextController.text == '1') {
                            return;
                          } else {
                            setState(() {
                              quantityTextController.text =
                                  (int.parse(quantityTextController.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        color: Colors.redAccent,
                        icon: CupertinoIcons.minus,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: quantityTextController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              if (v.isEmpty) {
                                quantityTextController.text = '1';
                              } else {}
                            });
                          },
                        ),
                      ),
                      quantityIconController(
                        fcn: () {
                          setState(() {
                            quantityTextController.text =
                                (int.parse(quantityTextController.text) + 1)
                                    .toString();
                          });
                        },
                        color: Colors.green,
                        icon: CupertinoIcons.add,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Total",
                                  color: Colors.red.shade400,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: "Rs 50.00 / ",
                                        color: color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        text:
                                            "${quantityTextController.text}Kg",
                                        color: color,
                                        textSize: 16,
                                        isTitle: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text: "Order Now",
                                      color: Colors.white,
                                      textSize: 20),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityIconController(
      {required Function fcn, required Color color, required IconData icon}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () {
              fcn();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
