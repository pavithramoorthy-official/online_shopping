import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utilities(context).getScreenSize;
    Color color = Utilities(context).color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
                        fit: BoxFit.fill,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Text("Edit"),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ])
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    TextWidget(
                      text: "Rs 50.00",
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                      visible: true,
                      child: Text("Rs 30.00",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: color,
                          )),
                    ),
                    const Spacer(),
                    TextWidget(
                      text: "Kg",
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                TextWidget(
                  text: "Title",
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
