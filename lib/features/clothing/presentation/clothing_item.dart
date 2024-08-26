//Generative Code
import 'package:flutter/material.dart';

class ClothingItem {
  final String name;
  final String location;
  final List<AssetImage> images;
  int currentIndex;
  final ClothingItemDetail details;

  ClothingItem(
      {required this.name,
      required this.location,
      required this.images,
      this.currentIndex = 0,
      required this.details});
}

class ClothingItemDetail {
  final String bio;
  final String type;
  final int size;
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

List swipeImages = [
  ClothingItem(
      name: 'Steve',
      location: 'Brisbane',
      images: [
        const AssetImage('lib/images/2.jpg'),
      ],
      details: ClothingItemDetail(
          bio:
              'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
          type: 'Shirt',
          size: 54,
          gender: 'Male',
          condition: 'Good',
          colours: ['Black'],
          images: ([
            const AssetImage('lib/images/1.jpg'),
            const AssetImage('lib/images/1-extra.jpg'),
          ]))),
  ClothingItem(
      name: 'Bob',
      location: 'Gold Coast',
      images: [
        const AssetImage('lib/images/3.jpg'),
      ],
      details: ClothingItemDetail(
          bio:
              'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
          type: 'Shirt',
          size: 54,
          gender: 'Male',
          condition: 'Good',
          colours: ['Black'],
          images: ([
            const AssetImage('lib/images/1.jpg'),
            const AssetImage('lib/images/1-extra.jpg'),
          ]))),
  ClothingItem(
    name: 'Jacob',
    location: 'Mount Cotton',
    images: [
      const AssetImage('lib/images/1.jpg'),
      const AssetImage('lib/images/1-extra.jpg'),
    ],
    details: ClothingItemDetail(
        bio:
            'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
        type: 'Shirt',
        size: 54,
        gender: 'Male',
        condition: 'Good',
        colours: ['Black'],
        images: ([
          const AssetImage('lib/images/1.jpg'),
          const AssetImage('lib/images/1-extra.jpg'),
        ])),
  ),
  ClothingItem(
    name: 'Pop',
    location: 'Sunshine Coast',
    images: [
      const AssetImage('lib/images/4.jpg'),
    ],
    details: ClothingItemDetail(
        bio:
            'This is an awesome black shirt that I really like a lot a lot a lot a lot a lot.',
        type: 'Shirt',
        size: 54,
        gender: 'Male',
        condition: 'Good',
        colours: ['Black'],
        images: ([
          const AssetImage('lib/images/1.jpg'),
          const AssetImage('lib/images/1-extra.jpg'),
        ])),
  ),
];
