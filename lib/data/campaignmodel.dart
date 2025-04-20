import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/data/productmodel.dart';

class Campaign {
  String name;
  String description;
  Timestamp startDate;
  Timestamp endDate;
  List? productIDs;
  Category? productUpperCategory;
  SubCategory? productInnerCategory;
  Image image;
  Campaign({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.image,
    this.productIDs,
    this.productInnerCategory,
    this.productUpperCategory,
  });
}
