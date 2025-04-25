import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/data/productmodel.dart';
import 'package:marketapp/screens/getdatascreen.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final List<SubCategory> subCategories;
  final String categoryName;
  const CategoryScreen({
    super.key,
    required this.category,
    required this.categoryName,
    required this.subCategories,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<Product> categoryProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryProducts = getCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar,
      endDrawer: Constants.drawer,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Constants.backgroundColor,
        shape: CircleBorder(),
        
        child: FaIcon(
          FontAwesomeIcons.filter,
          color: Constants.buttonBackgroundColor,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Center(
              child: Text(
                widget.categoryName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          widget.subCategories.isEmpty
              ? SizedBox()
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: returnSubCategoriesElevatedButtonList(),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ),

          Center(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 32,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Constants.returnProductWidget(
                  product: categoryProducts[index],
                );
              },
              itemCount: categoryProducts.length,
            ),
          ),
        ],
      ),
    );
  }

  List<Product> getCategoryProducts() {
    return productList.where((product) {
      if (product.upperCategory == widget.category) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Widget> returnSubCategoriesElevatedButtonList() {
    List<Widget> widgets = [];
    for (var subcategory in widget.subCategories) {
      String text = subcategory.name;
      widgets.add(
        ElevatedButton(
          onPressed: () {},
          child: Text(text[0].toUpperCase() + text.substring(1)),
        ),
      );
    }
    return widgets;
  }
}
