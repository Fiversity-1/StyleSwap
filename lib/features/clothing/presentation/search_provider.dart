import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:flutter/material.dart';

class Search with ChangeNotifier {
  List listings = [];

  //Get listings

  void resetSearch() {
    listings = [];
  }

  void removeListing(int index) {
    listings.removeAt(index);
    notifyListeners();
  }

  // Method to add an interested listing
  void setListings(List searchResults) {
    listings = searchResults;
    notifyListeners();
  }

  List getListing() {
    return listings;
  }
}
