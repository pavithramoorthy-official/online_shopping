import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialogue({
    required String title,
    required String subtitle,
    required Function fcn,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  fcn();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }));
  }

  static Future<void> errorDialogue({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              "An Error has occurred",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
