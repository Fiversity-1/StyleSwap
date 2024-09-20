import 'package:flutter/material.dart';

//Clothing Item Class - Each Item has a clothing itemdetail instance
class ClothingItem {
  final String id;
  final String userId;
  final String name;
  int currentIndex;
  final String location;
  final List<AssetImage> images;
  final ClothingItemDetail details;

  ClothingItem(
      {required this.id,
      required this.userId,
      required this.name,
      required this.location,
      required this.images,
      required this.details,
      this.currentIndex = 0});
}

class ClothingItemDetail {
  final String bio;
  final String type;
  final String size;
  final String gender;

  final String condition;
  final List<String> colours;
  final List<ImageProvider> images;
  ClothingItemDetail({
    required this.bio,
    required this.type,
    required this.size,
    required this.gender,
    required this.condition,
    required this.colours,
    required this.images,
  });
}
