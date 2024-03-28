import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/heart_icon.dart';
import 'package:grocery_shopping/widgets/price_widget.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class OnsaleWidget extends StatefulWidget {
  const OnsaleWidget({super.key});

  @override
  State<OnsaleWidget> createState() => _OnsaleWidgetState();
}

class _OnsaleWidgetState extends State<OnsaleWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utilities(context).getTheme;
    final Size size = Utilities(context).getScreenSize;
    Color color = Utilities(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      boxFit: BoxFit.fill,
                    ),
                    // Image.network(
                    //   'https://i.ibb.co/F0s3FHQ/Apricots.png',
                    //   width: size.width * 0.22,
                    //   height: size.width * 0.22,
                    //   fit: BoxFit.fill,
                    // ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: '1 KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 22,
                                color: color,
                              ),
                            ),
                            const HeartIconWidget(),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const PriceWidget(),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: "Mango",
                  color: color,
                  textSize: 17,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
