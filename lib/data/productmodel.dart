import 'package:flutter/material.dart';
import 'package:marketapp/data/commentmodel.dart';

class Product {
  String name;
  String description;
  double price;
  int stockCount;
  int sold;
  Category upperCategory;
  SubCategory? innerCategory;
  String id;
  List<Image> images;
  List<Comment> comments;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stockCount,
    required this.upperCategory,
    required this.sold,
    this.innerCategory,
    required this.id,
    required this.images,
    required this.comments,
  });
}

enum Category {
  percussionInstruments,
  stringInstruments,
  windInstruments,
  keyboardInstruments,
  pluckedStringInstruments,
  bowedStringInstruments,
  audioEquipments,
  generalMusicAccessories,
  stageEquipments,
}

enum SubCategory { instruments, accessories }
