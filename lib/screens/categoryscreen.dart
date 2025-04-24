import 'package:flutter/material.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/data/productmodel.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final List<SubCategory>? subCategories;
  const CategoryScreen({super.key, required this.category, this.subCategories});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Constants.appBar);
  }
}
