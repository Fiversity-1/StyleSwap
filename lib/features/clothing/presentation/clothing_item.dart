//Generative Code
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class ClothingItem {
  final String name;
  final String location;
  final List<AssetImage> images;
  int currentIndex;

  ClothingItem(
      {required this.name,
      required this.location,
      required this.images,
      this.currentIndex = 0});
}

class ClothingItemDetail {
  final String bio;
  final String type;
  final int size;
  final String gender;

  final String condition;
  final List<String> colours;
  final List<AssetImage> images;
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

ClothingItemDetail item = ClothingItemDetail(
    bio:
        'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
    type: 'Shirt',
    size: 54,
    gender: 'Male',
    condition: 'Good',
    colours: ['Black', 'Grey'],
    images: ([
      const AssetImage('lib/images/0.jpg'),
      const AssetImage('lib/images/watermelon.png'),
      const AssetImage('lib/images/watermelon2.jpg'),
    ]));

List swipeImages = [
  ClothingItem(name: 'Jacob', location: 'Mount Cotton', images: [
    const AssetImage('lib/images/0.jpg'),
    const AssetImage('lib/images/watermelon.png'),
    const AssetImage('lib/images/watermelon2.jpg'),
  ]),
  ClothingItem(name: 'Steve', location: 'Brisbane', images: [
    const AssetImage('lib/images/1.jpg'),
    const AssetImage('lib/images/watermelon.png'),
    const AssetImage('lib/images/watermelon2.jpg')
  ]),
  ClothingItem(name: 'Bob', location: 'Gold Coast', images: [
    const AssetImage('lib/images/2.jpg'),
    const AssetImage('lib/images/watermelon.png'),
    const AssetImage('lib/images/watermelon2.jpg')
  ]),
  ClothingItem(name: 'Pop', location: 'Sunshine Coast', images: [
    const AssetImage('lib/images/backdrop.jpg'),
    const AssetImage('lib/images/watermelon.png'),
    const AssetImage('lib/images/watermelon2.jpg')
  ]),
  ClothingItem(name: 'Shaq', location: 'Los Angeles', images: [
    const AssetImage('lib/images/backdrop2.jpg'),
    const AssetImage('lib/images/watermelon.png'),
    const AssetImage('lib/images/watermelon2.jpg')
  ]),
];
