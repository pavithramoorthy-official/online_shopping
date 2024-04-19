import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical: defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
          )),
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        size: 20,
      ),
      label: Text(text),
    );
  }
}
