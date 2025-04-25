import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/data/productmodel.dart';
import 'package:marketapp/screens/bestsellersscreen.dart';
import 'package:marketapp/screens/campaignscreen.dart';
import 'package:marketapp/screens/categoryscreen.dart';
import 'package:marketapp/screens/getdatascreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    removeOldCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: Constants.appBar,
      endDrawer: Constants.drawer,
      
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12),
            child: Text(
              "Current Campaigns",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: campaignsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Constants.push(
                        context: context,
                        destination: CampaignScreen(
                          campaign: campaignsList[index],
                        ),
                      );
                    },
                    child: Hero(
                      tag: campaignsList[index].name,
                      child: Container(
                        height: 200.h,
                        width: 315.w,
                        decoration: BoxDecoration(
                          color:
                              Colors
                                  .amber, // We will add images that have backgrounds so this line will work only at development
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: campaignsList[index].image,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Bestsellers Of All Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Constants.push(
                    context: context,
                    destination: BestSellersScreen(
                      bestsellers: getBestSellers(),
                    ),
                  );
                },
                child: Text("Show More"),
              ),
            ],
          ),
          SizedBox(
            height: 300.h,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    getBestSellers().length < 10 ? getBestSellers().length : 10,
                itemBuilder: (context, index) {
                  List<Product> bestSellers = getBestSellers();
                  Product currentBestSeller = bestSellers[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Constants.returnProductWidget(
                      product: currentBestSeller,
                    ),
                  );
                },
              ),
            ),
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Percussion",
            Category.percussionInstruments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Plucked String",
            Category.pluckedStringInstruments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Audio Equipments",
            Category.audioEquipments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Bowed String",
            Category.bowedStringInstruments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "General Music Accessories",
            Category.generalMusicAccessories,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Keyboard",
            Category.keyboardInstruments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Stage Equipments",
            Category.stageEquipments,
          ),
          returnHorizontalCategoriesWidgetGroup(
            "Wind",
            Category.windInstruments,
          ),
        ],
      ),
    );
  }

  Widget returnHorizontalCategoriesWidgetGroup(
    String categoryName,
    Category category,
  ) {
    List<Product> categoryProducts =
        productList.where((product) {
          if (product.upperCategory == category) {
            return true;
          } else {
            return false;
          }
        }).toList();
    if (categoryProducts.length > 10) {
      categoryProducts = categoryProducts.sublist(0, 10);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 1)),
      ),
      height: 300.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryProducts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  pushToCategoryScreenWithParameters(
                    categoryProducts,
                    category,
                    categoryName,
                  );
                },
                child: SizedBox(
                  width: 180.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade400,
                        radius: 60,
                        child: Image.asset(
                          "assets/images/${categoryName.replaceAll(" ", "").toLowerCase()}.png",
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 150.w,
                          child: Text(
                            categoryName,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              if (index == categoryProducts.length) {
                return SizedBox(
                  height: 300.h,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                          left: 8.0,
                        ),
                        child: Constants.returnProductWidget(
                          product: categoryProducts[index - 1],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          pushToCategoryScreenWithParameters(
                            categoryProducts,
                            category,
                            categoryName
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Constants.returnProductWidget(
                    product: categoryProducts[index - 1],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  void pushToCategoryScreenWithParameters(
    List<Product> categoryProducts,
    Category category,
    String categoryName,
  ) {
    Set<SubCategory> subCategories = {};
    for (Product product in categoryProducts) {
      if (product.innerCategory != null) {
        subCategories.add(product.innerCategory!);
      }
    }
    Constants.push(
      context: context,
      destination: CategoryScreen(
        category: category,
        categoryName: categoryName,
        subCategories: subCategories.toList(),
      ),
    );
  }

  List<Product> getBestSellers() {
    List<Product> sortedProductsList = productList;
    sortedProductsList.sort((a, b) => b.sold.compareTo(a.sold));
    if (sortedProductsList.length > 100) {
      return sortedProductsList.sublist(0, 100);
    } else {
      return sortedProductsList;
    }
  }

  void removeOldCampaigns() {
    // to fix ConcurrentModificationError list error
    // we used List.from().
    List.from(campaignsList).forEach((element) {
      if (element.endDate.toDate().isBefore(DateTime.now()) ||
          element.startDate.toDate().isAfter(DateTime.now())) {
        campaignsList.remove(element);
      }
    });
  }
}
