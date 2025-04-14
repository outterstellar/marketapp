import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  String name;
  String description;
  Timestamp startDate;
  Timestamp endDate;
  List? productIDs;
  String? productUpperCategory;
  String? productInnerCategory;
  Campaign({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.productIDs,
    this.productInnerCategory,
    this.productUpperCategory,
  });
}
