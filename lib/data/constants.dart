import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/productmodel.dart';

class Constants {
  static Color backgroundColor = Color(0xffF6F1DE);
  static Color primaryColor = Color(0xffACD3A8);
  static Color secondaryBackgroundColor = Color(0xffD4C9BE);
  static Color buttonBackgroundColor = Color(0xff123458);
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

  static Widget returnProductWidget({required Product product}) {
    final imageWidget =
        (product.images.isNotEmpty)
            ? product.images.first
            : const Placeholder(); // ya da bir Asset, örneğin: Image.asset("assets/placeholder.png")

    return Center(
      child: Container(
        height: 300.h,
        width: 180.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 150.h,
              width: 150.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageWidget,
              ),
            ),
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.amber[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text("${product.price} ₺"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
