import 'package:clothing_swap/features/clothing/presentation/clothing_item_build.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/fun_fact.dart';
import 'package:flutter/material.dart';

//Original code modified by chat to include _generatedisplayCards
//Need to replace publicListings to whatever search returns

class Search with ChangeNotifier {
  List _listings = [];
  final int _funFactInterval = 3;
  List searchResults = publicListings;

  void setSearch() {

  }

  void setListings() {
    final List displayCards = [];
    int funFactCount = 0;
    int totalItems = searchResults.length;

    for (int i = 0; i < totalItems; i++) {
      displayCards.add(ClothingCard(item: searchResults[i]));

      if ((i + 1) % _funFactInterval == 0 &&
          funFactCount < funFactDarkPhone.length) {
        displayCards.add(FunFactCard(index: funFactCount));
        funFactCount++;
      }
    }
    _listings = displayCards;
    notifyListeners();
  }
  //End gpt

  List<dynamic> getListing() {
    return _listings;
  }

  void removeListing(int index) {
    _listings.removeAt(index);
    notifyListeners();
  }

  String checkCardType() {
    if (getListing().isNotEmpty) {
      if (getListing()[0] is FunFactCard) {
        return "Fact";
      } else if (getListing()[0] is! FunFactCard) {
        return "Clothes";
      }
    }
    return "Empty";
  }
}
