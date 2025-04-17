import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/campaignmodel.dart';
import 'package:marketapp/data/commentmodel.dart';
import 'package:marketapp/data/productmodel.dart';
import 'package:marketapp/main.dart';
import 'package:marketapp/screens/mainscreen.dart';

import '../data/constants.dart';

List<Product> productList = [];
List<Campaign> campaignsList = [];

class GetDataScrren extends StatefulWidget {
  const GetDataScrren({super.key});

  @override
  State<GetDataScrren> createState() => _GetDataScrrenState();
}

class _GetDataScrrenState extends State<GetDataScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: Text("Liszt Müzik Market"),
        backgroundColor: Constants.backgroundColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                height: 300.h,
                width: 350.w,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Something Went Wrong! Please Check Everything And Try Again!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Constants.primaryColor,
                    strokeWidth: 4,
                  ),
                  Divider(height: 20.h, color: Colors.transparent),
                  Text("Loading...", style: TextStyle(fontSize: 17)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (result[0] == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future getData() async {
    bool result = false;
    result =
        await checkConnectivity(); // false => no connection, true => a type of connection
    if (result == false) {
      throw (Error());
    }
    productList = await getProducts();
    campaignsList = await getCampaigns();
    return result; // we dont need to return something. But we should return it to not cause an error.
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

  Future<List<Campaign>> getCampaigns() async {
    List<Campaign> campaigns = [];
    QuerySnapshot snapshot = await firestore.collection("campaigns").get();
    snapshot.docs.forEach((element) {
      Map currentCampaign = (element.data() as Map);
      campaigns.add(
        Campaign(
          name: currentCampaign["name"],
          description: currentCampaign["description"],
          startDate: currentCampaign["startDate"],
          endDate: currentCampaign["endDate"],
          productIDs: currentCampaign["productIDs"],
          image: Image.network(currentCampaign["image"]),
          productInnerCategory: currentCampaign["productInnerCategory"],
          productUpperCategory: currentCampaign["productUpperCategory"],
        ),
      );
    });
    return campaigns;
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
