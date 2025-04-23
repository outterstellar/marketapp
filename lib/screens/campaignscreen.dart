import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/campaignmodel.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/data/productmodel.dart';
import 'package:marketapp/screens/getdatascreen.dart';

class CampaignScreen extends StatefulWidget {
  final Campaign campaign;
  const CampaignScreen({super.key, required this.campaign});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Hero(
              tag: widget.campaign.name,
              child: Center(
                child: Container(
                  height: 200.h,
                  width: 315.w,
                  decoration: BoxDecoration(
                    color:
                        Colors
                            .amber, // We will add images that have backgrounds so this line will work only at development
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.campaign.image,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              widget.campaign.name,
              style: TextStyle(fontSize: 23),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(widget.campaign.description),
            ),
          ),
          Center(
            child: Text(
              "Kampanyanın Geçerli Olduğu Ürünler",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(height: 20, color: Colors.transparent),
          Center(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: campaignProductsList().length, // kampanyaların listesi
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 sütunlu yapı
                crossAxisSpacing: 16,
                mainAxisSpacing: 32,
                childAspectRatio: 0.7, // genişlik/yükseklik oranı
              ),
              itemBuilder: (context, index) {
                Product currentProduct = campaignProductsList()[index];
                return Constants.returnProductWidget(product: currentProduct);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Product> campaignProductsList() {
    List<Product> campaignProducts = [];
    if (widget.campaign.productIDs != null) {
      campaignProducts =
          productList.where((product) {
            String id = product.id;
            List campaignIDs = widget.campaign.productIDs!;
            return campaignIDs.contains(id);
          }).toList();
    } else if (widget.campaign.productUpperCategory != null &&
        widget.campaign.productInnerCategory == null) {
      campaignProducts =
          productList
              .where(
                (product) =>
                    product.upperCategory ==
                    widget.campaign.productUpperCategory,
              )
              .toList();
    } else {
      campaignProducts =
          productList
              .where(
                (product) =>
                    product.upperCategory ==
                        widget.campaign.productUpperCategory &&
                    product.innerCategory ==
                        widget.campaign.productInnerCategory,
              )
              .toList();
    }
    return campaignProducts;
  }
}
