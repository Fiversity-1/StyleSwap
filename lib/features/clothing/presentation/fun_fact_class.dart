import 'package:flutter/material.dart';

class FunFact {
  final AssetImage image;
  int currentIndex;

  FunFact({
    required this.image,
    this.currentIndex = 0,
  });
}

List funFactExample = [
  FunFact(image: const AssetImage('lib/images/funfact1.jpg')),
  FunFact(image: const AssetImage('lib/images/funfact2.jpg')),
  FunFact(image: const AssetImage('lib/images/funfact3.jpg'))
];
