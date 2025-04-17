import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Campaign {
  String name;
  String description;
  Timestamp startDate;
  Timestamp endDate;
  List? productIDs;
  String? productUpperCategory;
  String? productInnerCategory;
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
