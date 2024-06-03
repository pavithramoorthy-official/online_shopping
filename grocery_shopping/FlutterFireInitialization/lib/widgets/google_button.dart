import 'package:flutter/material.dart';
import 'package:grocery_shopping/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 7, 131, 233),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png', //assets\images\google.png
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextWidget(
              text: 'Sign in with Google',
              color: Colors.white,
              textSize: 18,
            )
          ],
        ),
      ),
    );
  }
}
