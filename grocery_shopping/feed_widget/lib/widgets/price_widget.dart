import 'package:flutter/material.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    Color color = utilities.color;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: "Rs 25.00",
            color: Colors.green,
            textSize: 17,
            isTitle: true,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "Rs 35.00",
            style: TextStyle(
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
