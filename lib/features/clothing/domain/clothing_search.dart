
import 'dart:ffi';

import 'clothing_info.dart';

class ClothingSearch {
  final List<ClothingType>? types;
  final List<ClothingSize>? sizes;
  final List<ClothingColour>? colours;
  final List<ClothingCondition>? conditions;
  final List<ClothingGender>? genders;
  final UnsignedInt distance;

  ClothingSearch(this.distance, {this.types, this.sizes, this.colours,
    this.conditions, this.genders});

  Map<String, dynamic> getData {
    return {
      "size": ["XXL", "S"],
      "colour": ["red", "blue"],
      "type": ["hat", "jumper"],
      "condition": ["new", "like-new"],
      "gender": ["male", "unisex"]
    };
  }
}