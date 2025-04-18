import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketapp/data/constants.dart';
import 'package:marketapp/screens/campaignscreen.dart';
import 'package:marketapp/screens/getdatascreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      ),
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
        ],
      ),
    );
  }
}
