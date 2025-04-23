import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/productmodel.dart';

class Constants {
  static Color backgroundColor = Color(0xffF6F1DE);
  static Color primaryColor = Color(0xffACD3A8);
  static Color secondaryBackgroundColor = Color(0xffD4C9BE);
  static Color buttonBackgroundColor = Color(0xff123458);
  static AppBar appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      'Liszt Music\nMarket',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.2, // Satır aralığı
      ),
    ),

    centerTitle: false,
    actions: [
      IconButton(
        icon: Icon(Icons.more_vert, color: Colors.black),
        onPressed: () {},
      ),
    ],
  );
  static Drawer drawer = Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            'Account',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ],
    ),
  );
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
    return Center(
      child: Container(
        height: 300.h,
        width: 180.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 150.h, width: 150.w, child: product.images[0]),
            Container(
              height: 100.h,
              width: 180.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product.name.split('').join('\u200B'), // to break word
                      style: TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                    ),
                    Text("There will be stars"),
                    Text(
                      product.price.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
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
