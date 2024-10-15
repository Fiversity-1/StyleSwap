import 'dart:ffi';
import 'dart:math';

import 'package:clothing_swap/features/clothing/domain/clothing_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_build.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/fun_fact.dart';
import 'package:flutter/material.dart';

import '../data/search_api.dart';
import '../presentation/clothing_item_class.dart';

//Original code modified by chat to include _generatedisplayCards
//Need to replace publicListings to whatever search returns

class FunFact {
  final int funFactId;

  FunFact(this.funFactId);
}

class Search with ChangeNotifier {
  final List _listings = [];
  final int _funFactInterval = 3;
  ClothingSearch searchParams = ClothingSearch(distance: 10);
  bool searching = false;
  bool searchExhausted = false;

  void setSearchParams(ClothingSearch searchParams) {
    this.searchParams = searchParams;

    _listings.clear();
    searchExhausted = false;

    notifyListeners();
  }

  void resetSearch() {
    searchExhausted = false;
  }
  //End gpt

  List getListing({bool update = true}) {
    if (_listings.length < 5 && !searching && !searchExhausted && update) {
      updateListing();
    }

    return _listings;
  }

  void updateListing() async {
    searching = true;

    var items = await searchClothes(searchParams);

    if (items.length < 5) {
      searchExhausted = true;
    }

    List<int> funFactIndexes = List.generate(numFunFacts, (index) => index);
    Random random = Random();

    for (var index = 0; index < items.length; index++) {
      if (index % _funFactInterval == 0 && index != 0 && funFactIndexes.isNotEmpty) {
        _listings.add(FunFact(funFactIndexes.removeAt(random.nextInt(funFactIndexes.length))));
      }

      _listings.add(items[index]);
    }

    searching = false;
    notifyListeners();
  }

  void removeListing(int index) {
    _listings.removeAt(index);
    notifyListeners();
  }

  String checkCardType() {
    if (getListing().isNotEmpty) {
      if (getListing()[0] is FunFact) {
        return "Fact";
      } else {
        return "Clothes";
      }
    }
    return "Empty";
  }
}
