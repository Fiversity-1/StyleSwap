import 'dart:math';

import 'package:clothing_swap/features/clothing/presentation/swipe_cards/fun_fact.dart';
import 'package:clothing_swap/features/preferences/domain/clothing_search.dart';
import 'package:flutter/material.dart';

import '../data/search_api.dart';

class FunFact {
  final int funFactId;

  FunFact(this.funFactId);
}

/// This ChangeNotifier stores the current search status including search
/// parameters.
class Search with ChangeNotifier {
  final List _listings = [];
  final int _funFactInterval = 3;
  ClothingSearch searchParams = ClothingSearch(distance: 10);
  bool searching = false;
  bool searchExhausted = false;

  // Set the search parameters and update listeners.
  void setSearchParams(ClothingSearch searchParams) {
    this.searchParams = searchParams;

    _listings.clear();
    searchExhausted = false;

    notifyListeners();
  }

  // Clear listings
  void resetSearch() {
    _listings.clear();
    searchExhausted = false;
  }

  // Get the current listings. If < 5 listings remaining and not searching,
  // attempt to fetch more listings.
  List getListing({bool update = true}) {
    if (_listings.length < 5 && !searching && !searchExhausted && update) {
      updateListing();
    }

    return _listings;
  }

  // Updates the listings by fetching from the API using the stored search
  // parameters.
  void updateListing() async {
    searching = true;

    var items = await searchClothes(searchParams);

    if (items.length < 5) {
      searchExhausted = true;
    }

    // Generate the fun facts to insert between.
    List<int> funFactIndexes = List.generate(numFunFacts, (index) => index);
    Random random = Random();

    for (var index = 0; index < items.length; index++) {
      if (index % _funFactInterval == 0 &&
          index != 0 &&
          funFactIndexes.isNotEmpty) {
        _listings.add(FunFact(
            funFactIndexes.removeAt(random.nextInt(funFactIndexes.length))));
      }

      _listings.add(items[index]);
    }

    searching = false;
    notifyListeners();
  }

  // Remove listing at the given index and notify listeners.
  void removeListing(int index) {
    _listings.removeAt(index);
    notifyListeners();
  }

  // Returns the type of the card.
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
