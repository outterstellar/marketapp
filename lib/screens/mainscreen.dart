import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/data/commentmodel.dart';
import 'package:marketapp/data/productmodel.dart';
import 'package:marketapp/main.dart';

import '../data/constants.dart';

List<Product> productList = [];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: FutureBuilder(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            productList = snapshot.data;
            return Text(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    QuerySnapshot snapshot = await firestore.collection("products").get();
    snapshot.docs.forEach((element) {
      Map currentProduct = (element.data() as Map);
      Map currentProuctComments = (currentProduct["comments"] as Map);
      List currentImages = (currentProduct["images"] as List);
      products.add(
        Product(
          name: currentProduct["name"],
          description: currentProduct["description"],
          price: double.parse(currentProduct["price"].toString()),
          stockCount: int.parse(currentProduct["stockCount"].toString()),
          innerCategory: currentProduct["innerCategory"],
          upperCategory: currentProduct["upperCategory"],
          id: currentProduct["id"],
          images: imageListToImageList(imageList: currentImages),
          comments: commentMapToCommentModelList(
            commentMap: currentProuctComments,
          ),
        ),
      );
    });
    return products;
  }

  List<Comment> commentMapToCommentModelList({required Map commentMap}) {
    List<Comment> comments = [];
    for (var element in commentMap.entries.toList()) {
      comments.add(
        Comment(
          user: element.key,
          stars: (element.value as List)[1],
          comment: (element.value as List)[0],
        ),
      );
    }
    return comments;
  }

  List<Image> imageListToImageList({required List imageList}) {
    List<Image> images = [];
    for (var element in imageList) {
      images.add(Image.network(element));
    }
    return images;
  }
}
