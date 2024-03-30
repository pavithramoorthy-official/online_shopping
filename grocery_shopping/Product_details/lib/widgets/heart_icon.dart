import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/services/utilities.dart';

class HeartIconWidget extends StatelessWidget {
  const HeartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Utilities(context).color;
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 22,
        color: color,
      ),
    );
  }
}
