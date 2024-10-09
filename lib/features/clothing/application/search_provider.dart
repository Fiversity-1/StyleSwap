import 'dart:ffi';

import 'package:clothing_swap/features/clothing/domain/clothing_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_build.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/fun_fact.dart';
import 'package:flutter/material.dart';

import '../data/search_api.dart';
import '../presentation/clothing_item_class.dart';

//Original code modified by chat to include _generatedisplayCards
//Need to replace publicListings to whatever search returns

class Search with ChangeNotifier {
  List _listings = [];
  final int _funFactInterval = 3;
  ClothingSearch searchParams = ClothingSearch(50);
  bool searching = false;
  bool searchExhausted = false;

  void setSearchParams(ClothingSearch searchParams) {
    this.searchParams = searchParams;
  }

  void resetSearch() {
    // final List displayCards = [];
    // int funFactCount = 0;
    // int totalItems = searchResults.length;
    //
    // for (int i = 0; i < totalItems; i++) {
    //   displayCards.add(ClothingCard(item: searchResults[i]));
    //
    //   if ((i + 1) % _funFactInterval == 0 &&
    //       funFactCount < funFactDarkPhone.length) {
    //     displayCards.add(FunFactCard(index: funFactCount));
    //     funFactCount++;
    //   }
    // }
    searchExhausted = false;
  }
  //End gpt

  List getListing() {
    if (_listings.length < 5 && !searching && !searchExhausted) {
      updateListing();
    }

    return _listings;
  }

  void updateListing() async {
    searching = true;
    notifyListeners();

    var items = await searchClothes(searchParams);

    if (items.length < 5) {
      searchExhausted = true;
    }

    _listings.addAll(items);
    searching = false;
    notifyListeners();
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
