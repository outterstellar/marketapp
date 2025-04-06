import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static Color backgroundColor = Color(0xffF6F1DE);
  static Color primaryColor = Color(0xffACD3A8);
  static Color secondaryBackgroundColor = Color(0xffD4C9BE);
  static Color buttonBackgroundColor= Color(0xff123458); 
  static void push({
    required BuildContext context,
    required Widget destination,
  }) {
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (context) => destination));
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void pushAndRemoveUntil({
    required BuildContext context,
    required Widget destination,
  }) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => destination),
      (route) => false,
    );
  }
}
