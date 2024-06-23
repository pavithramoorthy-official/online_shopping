import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utilities(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utilities(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Flexible(
                child: Image.network(
                  'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "12x For Rs 50.00",
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: "By",
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: "Vipanchi",
                            color: color,
                            textSize: 16,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "02/05/2024",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
