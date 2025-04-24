import 'package:flutter/material.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/data/productmodel.dart';

class BestSellersScreen extends StatefulWidget {
  final List<Product> bestsellers;
  const BestSellersScreen({super.key, required this.bestsellers});

  @override
  State<BestSellersScreen> createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Liszt Music\nMarket',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  "Bestsellers Of All Time",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Constants.returnProductWidget(
                  product: widget.bestsellers[index],
                );
              }, childCount: widget.bestsellers.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ikili ikili
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7, // oranı ihtiyacına göre ayarlarsın
              ),
            ),
          ),
        ],
      ),
    );
  }
}
