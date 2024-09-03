import 'package:flutter/material.dart';

class FunFact {
  final AssetImage image;
  int currentIndex;

  FunFact({
    required this.image,
    this.currentIndex = 0,
  });
}

List<FunFact> funFactDarkPhone = [
  FunFact(image: const AssetImage('lib/images/funFact1PhoneDark.png')),
  FunFact(image: const AssetImage('lib/images/funFact2PhoneDark.png')),
  FunFact(image: const AssetImage('lib/images/funFact3PhoneDark.png')),
];

List<FunFact> funFactLightPhone = [
  FunFact(image: const AssetImage('lib/images/funFact1PhoneLight.png')),
  FunFact(image: const AssetImage('lib/images/funFact2PhoneLight.png')),
  FunFact(image: const AssetImage('lib/images/funFact3PhoneLight.png')),
];
List<FunFact> funFactDarkWeb = [
  FunFact(image: const AssetImage('lib/images/funFact1WebDark.png')),
  FunFact(image: const AssetImage('lib/images/funFact2WebDark.png')),
  FunFact(image: const AssetImage('lib/images/funFact3WebDark.png')),
];
List<FunFact> funFactLightWeb = [
  FunFact(image: const AssetImage('lib/images/funFact1WebLight.png')),
  FunFact(image: const AssetImage('lib/images/funFact2WebLight.png')),
  FunFact(image: const AssetImage('lib/images/funFact3WebLight.png')),
];
