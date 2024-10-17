
import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../clothing/domain/clothing_info.dart';

class ClothingSearch extends ChangeNotifier {
  List<ClothingType>? types;
  List<ClothingSize>? sizes;
  List<ClothingColour>? colours;
  List<ClothingCondition>? conditions;
  List<ClothingGender>? genders;
  int? distance;

  ClothingSearch({this.types, this.sizes, this.colours,
    this.conditions, this.genders, this.distance});

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};

    addData(data, "type", types);
    addData(data, "size", sizes);
    addData(data, "colour", colours);
    addData(data, "condition", conditions);
    addData(data, "gender", genders);

    if (distance != null) {
      data["distance"] = distance.toString();
    }

    return data;
  }

  void addData(Map<String, dynamic> data, String key,
      List<DatabaseRepresentationMapper>? props) {
    if (props != null) {
      data[key] = props.map((type) => type.getDatabaseRepresentation()).toList();
    }
  }

  void updateTypes(List<ClothingType>? types) {
    this.types = types;

    notifyListeners();
  }

  void updateSizes(List<ClothingSize>? sizes) {
    this.sizes = sizes;

    notifyListeners();
  }

  void updateColours(List<ClothingColour>? colours) {
    this.colours = colours;

    notifyListeners();
  }

  void updateConditions(List<ClothingCondition>? conditions) {
    this.conditions = conditions;

    notifyListeners();
  }

  void updateGenders(List<ClothingGender>? genders) {
    this.genders = genders;

    notifyListeners();
  }

  void updateDistance(int? distance) {
    this.distance = distance;

    notifyListeners();
  }
}